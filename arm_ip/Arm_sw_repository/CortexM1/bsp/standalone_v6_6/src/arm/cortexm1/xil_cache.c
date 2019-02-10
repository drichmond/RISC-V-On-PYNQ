/******************************************************************************
*
* Copyright (C) 2010 - 2015 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xil_cache.c
*
* Contains required functions for the ARM cache functionality.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver    Who Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.00a  ecm 01/29/10 First release
* 1.00a  ecm 06/24/10 Moved the L1 and L2 specific function prototypes
*		      		  to xil_cache_mach.h to give access to sophisticated users
* 3.02a  sdm 04/07/11 Updated Flush/InvalidateRange APIs to flush/invalidate
*		      		  L1 and L2 caches in a single loop and used dsb, L2 sync
*		      		  at the end of the loop.
* 3.04a  sdm 01/02/12 Remove redundant dsb/dmb instructions in cache maintenance
*		      		  APIs.
* 3.07a  asa 07/16/12 Corrected the L1 and L2 cache invalidation order.
* 3.07a  sgd 09/18/12 Corrected the L2 cache enable and disable sequence.
* 3.10a  srt 04/18/13 Implemented ARM Erratas. Please refer to file
*		      		  'xil_errata.h' for errata description
* 3.10a  asa 05/13/13 Modified cache disable APIs. The L2 cache disable
*			  		  operation was being done with L1 Data cache disabled. This is
*			  		  fixed so that L2 cache disable operation happens independent of
*			  		  L1 cache disable operation. This fixes CR #706464.
*			  		  Changes are done to do a L2 cache sync (poll reg7_?cache_?sync).
*			  		  This is done to fix the CR #700542.
* 3.11a  asa 09/23/13 Modified the Xil_DCacheFlushRange and
*			 		  Xil_DCacheInvalidateRange to fix potential issues. Fixed other
*			 		  relevant cache APIs to disable and enable back the interrupts.
*			 		  This fixes CR #663885.
* 3.11a  asa 09/28/13 Made changes for L2 cache sync operation. It is found
*			 		  out that for L2 cache flush/clean/invalidation by cache lines
*			 		  does not need a cache sync as these are atomic nature. Similarly
*			 		  figured out that for complete L2 cache flush/invalidation by way
*			 		  we need to wait for some more time in a loop till the status
*			 		  shows that the cache operation is completed.
* 4.00	 pkp 24/01/14 Modified Xil_DCacheInvalidateRange to fix the bug. Few
*			 		  cache lines were missed to invalidate when unaligned address
*			 		  invalidation was accommodated. That fixes CR #766768.
*			 		  Also in Xil_L1DCacheInvalidate, while invalidating all L1D cache
*			 		  stack memory which contains return address was invalidated. So
*			 		  stack memory was flushed first and then L1D cache is invalidated.
*			 		  This is done to fix CR #763829
* 4.01   asa 05/09/14 Made changes in cortexa9/xil_cache.c to fix CR# 798230.
* 4.02	 pkp 06/27/14 Added notes to Xil_L1DCacheInvalidateRange function for
*					  explanation of CR#785243
* 5.00   kvn 12/15/14 Xil_L2CacheInvalidate was modified to fix CR# 838835. L2 Cache
*					  has stack memory which has return address. Before invalidating
*					  cache, stack memory was flushed first and L2 Cache is invalidated.
* 5.01	 pkp 05/12/15 Xil_DCacheInvalidateRange and Xil_DCacheFlushRange is modified
*					  to remove unnecessary dsb in the APIs. Instead of using dsb
*					  for L2 Cache, L2CacheSync has been used for each L2 cache line
*					  and single dsb has been used for L1 cache. Also L2CacheSync is
*					  added into Xil_L2CacheInvalidateRange API. Xil_L1DCacheInvalidate
*					  and Xil_L2CacheInvalidate APIs are modified to flush the complete
*					  stack instead of just System Stack
* 5.03	 pkp 10/07/15 L2 Cache functionalities are avoided for the OpenAMP slave
*					  application(when USE_AMP flag is defined for BSP) as master CPU
*					  would be utilizing L2 cache for its operation
* 6.6    mus 12/07/17 Errata 753970 is not applicable for the PL130 cache controller
*                     version r0p2, which is present in zynq. So,removed the handling
*                     related to same.It fixes CR#989132.
* 6.6    asa 16/01/18 Changes made in Xil_L1DCacheInvalidate and Xil_L2CacheInvalidate
*					  routines to ensure the stack data flushed only when the respective
*					  caches are enabled. This fixes CR-992023.
*
* </pre>
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xil_cache.h"
#include "xparameters.h"

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/


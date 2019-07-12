extern unsigned long _data_begin;
extern unsigned long _data_end;
extern unsigned long _bss_begin;
extern unsigned long _bss_end;
extern unsigned long _stack_end;
extern int main();
void end_program(int retval){
  *(&_stack_end-1) = retval;
  while(1);
}
void handler_reset(void)
{
  int retval;
  unsigned long *destination;
  int argc;
  char ** argv;
  // default zero to undefined variables
  for (destination = &_bss_begin; destination < &_bss_end;)
    {
      *(destination++) = 0;
    }
  // starting main program
  argc = *(&_stack_end);
  argv = *(&_stack_end + 1);
  retval = main(argc, argv);
  end_program(retval);
}

void handler_default(void)
{
  while (1)
    {
      //loop
    }
}


__attribute__ ((section(".interrupt_vector")))
void (* const table_interrupt_vector[])(void) =
{
  (void *) &_stack_end, // 0 - stack
  handler_reset, // 1
  handler_default, // 2
  handler_default, // 3
  handler_default, // 4
  handler_default, // 5
  handler_default, // 6
  0, // 7
  0, // 8
  0, // 9
  0, // 10
  handler_default, // 11
  handler_default, // 12
  0, // 13
  handler_default, // 14
  handler_default, // 15
  // peripherals
  handler_default, // 0
  handler_default, // 1
  handler_default, // 2
  handler_default, // 3
  handler_default, // 4
  //-
  handler_default, // 59
  handler_default // 60
};


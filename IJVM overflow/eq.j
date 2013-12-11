.method main			// int main
.args	3			// ( int a, int b )
.define a = 1
.define b = 2

		iload a
		iload b
		isub
		ifeq true	// if(a-b = 0) true();
false:		bipush 0	// return 0;
		goto return
true:		bipush 1	// return 1;
return:		ireturn		// }

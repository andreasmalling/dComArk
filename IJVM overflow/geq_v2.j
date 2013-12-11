.method main			// int main
.args	3			// ( int a, int b )
.define a = 1
.define b = 2

checkA:		iload a
		iflt checkB	// if(a>=0) {
		iload b
		iflt true	// if(a>=0 && b<0) true();
		goto sameSign	// else sameSign(a,b); }
checkB:		iload b
		iflt sameSign	// if(a<0 && b<0) sameSign(a,b);
		goto false	// else false();
sameSign:	iload a
		iload b
		isub
		iflt false	// if(a-b < 0) false();
true:		bipush 1	// return 1;
		goto return
false:		bipush 0	// return 0;
return:		ireturn		// }

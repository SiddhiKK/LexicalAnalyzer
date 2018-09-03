%{
	#include<string.h>
	int insert(char[],char[]);
	int l=1,c=0,t=0;
	struct table
	{
		char n[20];
		char val[10];
		char typ[10];
	}st[50];
%} 

%%
[\n]* 						{l++;}
\/\*(.|\n)*\*\/ 			{  printf("\t****************Comment****************\n"); }
\/\/.* 						{  printf("\t*****************Comment***************\n"); }
\".*\"  					{ printf("\t%s\t\tString literal\t\t%d\n",yytext,l);  }
\, 							{ printf("\t,\t\tcomma\t\t\t%d\n",l);  }
\{ 							{ printf("\t{\t\tOpen curly bracket\t\t%d\n",l);  }
\} 							{ printf("\t}\t\tClose curly bracket\t\t%d\n",l);  }
\; 							{ printf("\t;\t\tsemicolon\t\t%d\n",l);  }
\"[_a-zA-Z0-9\-%= ]*\'   	{ printf("\t*****************ERROR*****************\n"); }
main  						{ printf("\tmain()\t\tMain function\t\t%d\n",l); }
\# 							{ printf("\t#\t\tPreprocessor\t\t%d\n",l); }
\> 							{ printf("\t>\t\tgreater than\t\t%d\n",l); }
\( 							{ printf("\t(\t\topen round bracket\t\t%d\n",l);  }
\) 							{ printf("\t)\t\tclose round bracket\t\t%d\n",l);  }
include 					{ printf("\tinclude\t\tInclude\t\t\t%d\n",l); }
\<  						{ printf("\t<\t\tless than\t\t%d\n",l); }
[0-9]* 						{ printf("\t%s\t\tInteger\t\t\t%d\n",yytext,l);  }
printf|scanf|if|else|do|while|case|switch|for|struct { printf("\t%s\t\tKeyword\t\t\t%d\n",yytext,l);  } 
int 						{ printf("\t%s\t\tInteger datatype\t\t%d\n",yytext,l); strcpy(st[t].typ,"int"); }
float 						{ printf("\t%s\t\tFloat datatype\t\t%d\n",yytext,l); strcpy(st[t].typ,"float");}
short 						{ printf("\t%s\t\tShort datatype\t\t%d\n",yytext,l); strcpy(st[t].typ,"short");}
void 						{ printf("\t%s\t\tVoid datatype\t\t%d\n",yytext,l); strcpy(st[t].typ,"void");} 
char 						{ printf("\t%s\t\tCharacter datatype\t\t%d\n",yytext,l); strcpy(st[t].typ,"char");}    
double 						{ printf("\t%s\t\tDouble datatype\t\t%d\n",yytext,l); strcpy(st[t].typ,"double");}
[0-9]+\.[0-9]* 				{ printf("\t%s\t\tFloat number\t\t\t%d\n",yytext,l);  }
[a-zA-Z_]+[_a-zA-Z0-9]*		{ printf("\t%s\t\tIdentifier\t\t%d\n",yytext,l); 
			  insert(yytext,"0"); 
			  t++; 
                          int j=t-1;
                          strcpy(st[t].typ,st[j].typ);
                        } 
\+|\-|\*|\/|\%|\&  			{ printf("\t%s\t\tOperator\t\t%d\n",yytext,l); }
\= 							{ printf("\t%s\t\tAssignment Operator\t\t%d\n",yytext,l); }
\" 							{ printf("\t%s\t\tquotes\t\t\t%d\n",yytext,l);  }
[a-zA-Z0-9]*\.h  			{ printf("\t%s\t\theader file\t\t%d\n",yytext,l); }
[0-9]+[a-zA-Z0-9]* 			{ printf("\t******************ERROR******************\n");}

%%  

int main()
{
	char fname[20];
	printf("Enter the file name: ");
	scanf("%s",fname);
	yyin=fopen(fname,"r");
	if(yyin == NULL)
	{
		printf("FILE NOT FOUND");
		return 0;
	}
	printf("\n\tLEXEME \t\t  TOKENS \t\t LINE NO.");
	printf("\n-----------------------------------------------------------\n");
	yylex();
	printf("\n\nSymbol Table:\n");
	printf("\nVARIABLE\tVALUE\t\tDATATYPE");
	printf("\n--------------------------------------");
	int i;
	for(i=0;i<c;i++)
	{
		printf("\n%s",st[i].n);
		if(!strcmp(st[i].typ,"char"))
			strcpy(st[i].val,"null"); 
		else if(!strcmp(st[i].typ,"int"));
		else
			strcpy(st[i].val,"0.0"); 
		printf("\t\t%s",st[i].val);
		printf("\t\t%s",st[i].typ);
	}
	printf("\n");
}

int insert(char a[10],char b[10])
{
	int i;
	for(i=0;i<c;i++)
	{
		if(strcmp(a,st[i].n)==0) return i;
	}
	strcpy(st[c].n,a);
	strcpy(st[c].val,b);
	return c++;
}

int yywrap()
{
	return 1;
}




// SAUVEGARDE

// On LIT les 16 Fichiers et on les Sauvegarde dans le Répertoire \Sauvegarde de la Clé USB...


// SOURCE : RT6

#define SOURCE_01     "/SDC/Data_Base/Graphics/Logo/Citroen.bmp"
#define SOURCE_02     "/SDC/Data_Base/Graphics/Logo/Citroen.bmp.inf"
#define SOURCE_03     "/SDC/Data_Base/Graphics/Logo/Premium_Citroen.bmp"
#define SOURCE_04     "/SDC/Data_Base/Graphics/Logo/Premium_Citroen.bmp.inf"

#define SOURCE_05     "/SDC/Data_Base/Graphics/Logo/STT_Citroen.bmp"
#define SOURCE_06     "/SDC/Data_Base/Graphics/Logo/STT_Citroen.bmp.inf"
#define SOURCE_07     "/SDC/Data_Base/Graphics/Logo/STT_Premium_Citroen.bmp"
#define SOURCE_08     "/SDC/Data_Base/Graphics/Logo/STT_Premium_Citroen.bmp.inf"

#define SOURCE_09     "/SDC/Data_Base/Graphics/Logo/Peugeot.bmp"
#define SOURCE_10     "/SDC/Data_Base/Graphics/Logo/Peugeot.bmp.inf"
#define SOURCE_11     "/SDC/Data_Base/Graphics/Logo/Premium_Peugeot.bmp"
#define SOURCE_12     "/SDC/Data_Base/Graphics/Logo/Premium_Peugeot.bmp.inf"

#define SOURCE_13     "/SDC/Data_Base/Graphics/Logo/STT_Peugeot.bmp"
#define SOURCE_14     "/SDC/Data_Base/Graphics/Logo/STT_Peugeot.bmp.inf"
#define SOURCE_15     "/SDC/Data_Base/Graphics/Logo/STT_Premium_Peugeot.bmp"
#define SOURCE_16     "/SDC/Data_Base/Graphics/Logo/STT_Premium_Peugeot.bmp.inf"

// DESTINATION : Clé USB

#define DESTIN_01     "/bd0/Sauvegarde/Citroen.bmp"
#define DESTIN_02     "/bd0/Sauvegarde/Citroen.bmp.inf"
#define DESTIN_03     "/bd0/Sauvegarde/Premium_Citroen.bmp"
#define DESTIN_04     "/bd0/Sauvegarde/Premium_Citroen.bmp.inf"

#define DESTIN_05     "/bd0/Sauvegarde/STT_Citroen.bmp"
#define DESTIN_06     "/bd0/Sauvegarde/STT_Citroen.bmp.inf"
#define DESTIN_07     "/bd0/Sauvegarde/STT_Premium_Citroen.bmp"
#define DESTIN_08     "/bd0/Sauvegarde/STT_Premium_Citroen.bmp.inf"

#define DESTIN_09     "/bd0/Sauvegarde/Peugeot.bmp"
#define DESTIN_10     "/bd0/Sauvegarde/Peugeot.bmp.inf"
#define DESTIN_11     "/bd0/Sauvegarde/Premium_Peugeot.bmp"
#define DESTIN_12     "/bd0/Sauvegarde/Premium_Peugeot.bmp.inf"

#define DESTIN_13     "/bd0/Sauvegarde/STT_Peugeot.bmp"
#define DESTIN_14     "/bd0/Sauvegarde/STT_Peugeot.bmp.inf"
#define DESTIN_15     "/bd0/Sauvegarde/STT_Premium_Peugeot.bmp"
#define DESTIN_16     "/bd0/Sauvegarde/STT_Premium_Peugeot.bmp.inf"

#define TRUE	(1)
#define FALSE   (0)
#define YES     (1)
#define NO      (0)
#define OK      (0)
#define ERROR   (-1)
#define SKIP    (1)
#define NULL    (void*) 0

// TYPES
typedef void FILE;
typedef int  size_t;

int  UPGMKDir (char* p_dir);
int  UPGDelete ( char * P_file );
int  CheckCRCFile(char *l_file);
int  UPGCopy (char *src,char *dst,int cut);
int  UPGGetSearchResult(int index , char *SearchResult);
int  GetFileSize (char* file, int* size);
int  ShowNavigationQuestionScreen(char *text, int *answer);
int  ShowNavigationBargraph( void );
int  StepBargraph(char *txt, int per);
int  ClearScreen(void);
int  taskDelay(int ticks);

FILE* fopen  ( char * file, char * mode );
int   fclose ( FILE * fp );
char* fgets  ( char * buf, size_t n, FILE * fp );
int   fputs  ( char * s, FILE * fp );
int   feof   ( FILE * fp );
int   fseek  ( FILE * fp, long offset, int whence );

char* strcpy  (char* target, char* source);
char* strcat  (char* target, char* source);
char* strrchr (char* target, char c);
int   strcmp  (char* str1, char* str2);

int  PL_FileExists( char *p_pPath );
void PL_itoa10( int i , char* s );

/*** MAIN ***/

int main ( int argc, char **argv )
{
  char s_nb[16];
  char MessPL[256];
  int nb;
  int size;
  int answ;  
	
  ClearScreen();
  ShowNavigationBargraph();

  // Création du Répertoire de Sauvegarde...
  UPGMKDir ( "/bd0/Sauvegarde/" );
  
  nb = 0;

  if( PL_FileExists ( SOURCE_01 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_01 , DESTIN_01 ,0 );
    StepBargraph("SOURCE_01 OK",6);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_02 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_02 , DESTIN_02 ,0 );
    StepBargraph("SOURCE_02 OK",12);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_03 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_03 , DESTIN_03 ,0 );
    StepBargraph("SOURCE_03 OK",18);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_04 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_04 , DESTIN_04 ,0 );
    StepBargraph("SOURCE_04 OK",25);
    taskDelay(250);
  }

    if( PL_FileExists ( SOURCE_05 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_05 , DESTIN_05 ,0 );
    StepBargraph("SOURCE_05 OK",31);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_06 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_06 , DESTIN_06 ,0 );
    StepBargraph("SOURCE_06 OK",37);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_07 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_07 , DESTIN_07 ,0 );
    StepBargraph("SOURCE_07 OK",43);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_08 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_08 , DESTIN_08 ,0 );
    StepBargraph("SOURCE_08 OK",50);
    taskDelay(250);
  }
 
   if( PL_FileExists ( SOURCE_09 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_09 , DESTIN_09 ,0 );
    StepBargraph("SOURCE_09 OK",56);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_10 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_10 , DESTIN_10 ,0 );
    StepBargraph("SOURCE_10 OK",62);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_11 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_11 , DESTIN_11 ,0 );
    StepBargraph("SOURCE_11 OK",68);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_12 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_12 , DESTIN_12 ,0 );
    StepBargraph("SOURCE_12 OK",75);
    taskDelay(250);
  }
 
   if( PL_FileExists ( SOURCE_13 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_13 , DESTIN_13 ,0 );
    StepBargraph("SOURCE_13 OK",81);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_14 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_14 , DESTIN_14 ,0 );
    StepBargraph("SOURCE_14 OK",87);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_15 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_15 , DESTIN_15 ,0 );
    StepBargraph("SOURCE_15 OK",93);
    taskDelay(250);
  }
  if( PL_FileExists ( SOURCE_16 ) == TRUE )
  {
    nb++ ;
    UPGCopy( SOURCE_16 , DESTIN_16 ,0 );
    StepBargraph("SOURCE_16 OK",100);
    taskDelay(250);
  }
  
  PL_itoa10(nb,s_nb);
 
  ClearScreen();

  strcpy(MessPL,s_nb);
  
  if( nb > 1 )
     strcat(MessPL," Fichiers Sauvegardés.");
  else
     strcat(MessPL," Fichier Sauvegardé.");

  ShowNavigationBargraph();
  StepBargraph(MessPL,100);

  taskDelay(2000);

  ClearScreen();

  return OK;
}

void PL_itoa10 (int i , char* s)
{
	char l_s[16];
	int  n = 0 , m = 0;
	if ( i < 0 )
	{
		s[m++] = '-';
		i=-i;
	}
	do
	{
		l_s[n++] = (char)('0'+(i%10));
		i /= 10;
	}
	while ( i );
	for ( --n ; n>=0 ; n--,m++ )
		s[m] = l_s[n];
	s[m]=0;
}

int PL_FileExists ( char *p_pPath )
{
	FILE* l_pFich = NULL;

	if (NULL == (l_pFich = fopen (p_pPath, "r")))
	{
		return (FALSE);
	}
	else
	{
		fclose (l_pFich);
		return (TRUE);
	}
}

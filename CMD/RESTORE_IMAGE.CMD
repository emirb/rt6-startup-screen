
// RESTAURATION

// ENVOIE 16 Fichiers au RT6...

// SOURCE : Clé USB

#define SOURCE_01 "/bd0/Sauvegarde/Citroen.bmp"
#define SOURCE_02 "/bd0/Sauvegarde/Citroen.bmp.inf"
#define SOURCE_03 "/bd0/Sauvegarde/Premium_Citroen.bmp"
#define SOURCE_04 "/bd0/Sauvegarde/Premium_Citroen.bmp.inf"

#define SOURCE_05 "/bd0/Sauvegarde/STT_Citroen.bmp"
#define SOURCE_06 "/bd0/Sauvegarde/STT_Citroen.bmp.inf"
#define SOURCE_07 "/bd0/Sauvegarde/STT_Premium_Citroen.bmp"
#define SOURCE_08 "/bd0/Sauvegarde/STT_Premium_Citroen.bmp.inf"

#define SOURCE_09 "/bd0/Sauvegarde/Peugeot.bmp"
#define SOURCE_10 "/bd0/Sauvegarde/Peugeot.bmp.inf"
#define SOURCE_11 "/bd0/Sauvegarde/Premium_Peugeot.bmp"
#define SOURCE_12 "/bd0/Sauvegarde/Premium_Peugeot.bmp.inf"

#define SOURCE_13 "/bd0/Sauvegarde/STT_Peugeot.bmp"
#define SOURCE_14 "/bd0/Sauvegarde/STT_Peugeot.bmp.inf"
#define SOURCE_15 "/bd0/Sauvegarde/STT_Premium_Peugeot.bmp"
#define SOURCE_16 "/bd0/Sauvegarde/STT_Premium_Peugeot.bmp.inf"

// DESTINATION : RT6

#define DESTIN_01      "/SDC/Data_Base/Graphics/Logo/Citroen.bmp"
#define DESTIN_02      "/SDC/Data_Base/Graphics/Logo/Citroen.bmp.inf"
#define DESTIN_03      "/SDC/Data_Base/Graphics/Logo/Premium_Citroen.bmp"
#define DESTIN_04      "/SDC/Data_Base/Graphics/Logo/Premium_Citroen.bmp.inf"

#define DESTIN_05      "/SDC/Data_Base/Graphics/Logo/STT_Citroen.bmp"
#define DESTIN_06      "/SDC/Data_Base/Graphics/Logo/STT_Citroen.bmp.inf"
#define DESTIN_07      "/SDC/Data_Base/Graphics/Logo/STT_Premium_Citroen.bmp"
#define DESTIN_08      "/SDC/Data_Base/Graphics/Logo/STT_Premium_Citroen.bmp.inf"

#define DESTIN_09      "/SDC/Data_Base/Graphics/Logo/Peugeot.bmp"
#define DESTIN_10      "/SDC/Data_Base/Graphics/Logo/Peugeot.bmp.inf"
#define DESTIN_11      "/SDC/Data_Base/Graphics/Logo/Premium_Peugeot.bmp"
#define DESTIN_12      "/SDC/Data_Base/Graphics/Logo/Premium_Peugeot.bmp.inf"

#define DESTIN_13      "/SDC/Data_Base/Graphics/Logo/STT_Peugeot.bmp"
#define DESTIN_14      "/SDC/Data_Base/Graphics/Logo/STT_Peugeot.bmp.inf"
#define DESTIN_15      "/SDC/Data_Base/Graphics/Logo/STT_Premium_Peugeot.bmp"
#define DESTIN_16      "/SDC/Data_Base/Graphics/Logo/STT_Premium_Peugeot.bmp.inf"

#define TRUE	(1)
#define FALSE   (0)
#define YES     (1)
#define NO      (0)
#define OK      (0)
#define ERROR   (-1)
#define SKIP    (1)
#define NULL    (void * ) 0

// TYPES
typedef void FILE;
typedef int  size_t;

int  UPGDelete ( char * P_file );
int  CheckCRCFile(char *l_file);
int  UPGCopy(char *src,char *dst,int cut);
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

  nb = 0;

  if ( PL_FileExists ( SOURCE_01 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_02 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_01 ) == OK )
      {
        StepBargraph( "SOURCE_02 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_01 , DESTIN_01 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_01 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_02 , DESTIN_02 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_02 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_02 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_01 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_02 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_02 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_01 ABSENT !" ,0);
    taskDelay(2000);
  }

  if ( PL_FileExists ( SOURCE_03 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_04 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_03 ) == OK )
      {
        StepBargraph( "SOURCE_04 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_03 , DESTIN_03 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_03 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_04 , DESTIN_04 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_04 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_04 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_03 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_04 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_04 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_03 ABSENT !" ,0);
    taskDelay(2000);
  }
  
  if ( PL_FileExists ( SOURCE_05 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_06 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_05 ) == OK )
      {
        StepBargraph( "SOURCE_06 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_05 , DESTIN_05 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_05 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_06 , DESTIN_06 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_06 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_06 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_05 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_06 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_06 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_05 ABSENT !" ,0);
    taskDelay(2000);
  }
  
  if ( PL_FileExists ( SOURCE_07 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_08 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_07 ) == OK )
      {
        StepBargraph( "SOURCE_08 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_07 , DESTIN_07 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_07 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_08 , DESTIN_08 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_08 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_08 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_07 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_08 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_08 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_07 ABSENT !" ,0);
    taskDelay(2000);
  }

  if ( PL_FileExists ( SOURCE_09 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_10 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_09 ) == OK )
      {
        StepBargraph( "SOURCE_10 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_09 , DESTIN_09 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_09 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_10 , DESTIN_10 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_10 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_10 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_09 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_10 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_10 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_09 ABSENT !" ,0);
    taskDelay(2000);
  }

  if ( PL_FileExists ( SOURCE_11 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_12 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_11 ) == OK )
      {
        StepBargraph( "SOURCE_12 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_11 , DESTIN_11 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_11 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_12 , DESTIN_12 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_12 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_12 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_11 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_12 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_12 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_11 ABSENT !" ,0);
    taskDelay(2000);
  }

  if ( PL_FileExists ( SOURCE_13 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_14 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_13 ) == OK )
      {
        StepBargraph( "SOURCE_14 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_13 , DESTIN_13 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_13 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_14 , DESTIN_14 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_14 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_14 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_13 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_14 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_14 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_13 ABSENT !" ,0);
    taskDelay(2000);
  }

  if ( PL_FileExists ( SOURCE_15 ) == TRUE )
  {
    if ( PL_FileExists ( SOURCE_16 ) == TRUE )
    {
      if ( CheckCRCFile( SOURCE_15 ) == OK )
      {
        StepBargraph( "SOURCE_16 CRC OK !" ,25);
        taskDelay(1000);
        if( UPGCopy( SOURCE_15 , DESTIN_15 ,0 ) == OK )
        {
          nb++ ;
          StepBargraph( "SOURCE_15 Copié !" ,50);
          taskDelay(1000);
          if( UPGCopy( SOURCE_16 , DESTIN_16 ,0 ) == OK )
          {
            nb++ ;
            StepBargraph( "SOURCE_16 Copié !" ,100);
            taskDelay(1000);
          }
          else
          {
            StepBargraph( "SOURCE_16 COPIE ERREUR !" ,0);
            taskDelay(2000);
          }
        }
        else
        {
          StepBargraph( "SOURCE_15 COPIE ERREUR !" ,0);
          taskDelay(2000);
        }
      }
      else
      {
        StepBargraph( "SOURCE_16 INCORRECT !" ,0);
        taskDelay(2000);
      }
    }
    else
    {
      StepBargraph( "SOURCE_16 ABSENT !" ,0);
      taskDelay(2000);
    }
  }
  else
  {
    StepBargraph( "SOURCE_15 ABSENT !" ,0);
    taskDelay(2000);
  }
  
  PL_itoa10( nb , s_nb );
 
  ClearScreen ();
  ShowNavigationBargraph ();

  strcpy( MessPL , s_nb );
  if( nb > 1 )
     strcat( MessPL , " Fichiers Restaurés." );
  else
     strcat( MessPL , " Fichier Restauré." );

  StepBargraph( MessPL , 100 );
  taskDelay( 2000 );

  if( nb > 0 )
  {
	  	StepBargraph( "Vous DEVEZ maintenant..." , 0);
		taskDelay( 1500 );
		StepBargraph( "FERMER la Voiture à Clé..." , 25);
		taskDelay( 1500 );
		StepBargraph( "et ATTENDRE 15 Minutes..." , 50);
		taskDelay( 1500 );
        StepBargraph( "ou pas, voir tutoriel..." , 75);
		taskDelay( 1500 );
        StepBargraph( "DS3Spirit.com" , 100);
		taskDelay( 3000 );
  }
					
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




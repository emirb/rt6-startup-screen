/*
 * POI_UPGRADE_RNEG.CMD  by mira308sw
 *
 * Modified poi update script for RT6 / emyway+ / RNEG2011
 * This script search for other *.CMD, ask the user, and run it.
 *
 * v 01.00: 02/04/2011  first release
 *
 * Modifié par Patrick LEVESQUE le 30/10/2014
 * ==========================================
 *
*/

#define DEF_CMD_DIR "/CMD"

/*** TYPES ***/

typedef int  STATUS;
typedef int  BOOL;
typedef void *MODULE_ID;


/*** CONSTANTS ***/

#define YES      (1)
#define NO       (0)
#define OK       (0)
#define ERROR    (-1)
#define SKIP     (1)
#define NULL     (void*) 0

#define LOAD_NO_SYMBOLS         2
#define LOAD_LOCAL_SYMBOLS      4
#define LOAD_GLOBAL_SYMBOLS     8
#define LOAD_ALL_SYMBOLS       12

#define BUILTINS_FILE_NORMAL  "/UPG/builtinsRNEG.out"

// Drive letters
#define DRIVE_HDD       "/SDC"
#define DRIVE_CD        "/D"
#define DRIVE_TFFS      "/F"
#define DRIVE_NAV       "/SDH"
#define DRIVE_USER      "/SDI"
#define DRIVE_USB       "/bd0"
#define DRIVE_JBX       "/J"


/*** EXTERN FUNCTION DEFINITIONS ***/

int       UPGSearchFile       (char* Filename, char *RootDir, char *Param, char *TableDir );
STATUS    UPGGetSearchResult  (int index , char *SearchResult );
int       EiC_ExeFile         (int argc, char **argv);
MODULE_ID LoadAndExecuteFile(char* p_root,char* p_file_name,int p_ld_symb, int p_invalid,unsigned int p_delay);
STATUS    ShowCDIdentification(void);


char*   strcpy              (char* target, char* source);
char*   strcat              (char* target, char* source);
char*   strrchr             (char* target, char c);
int     strcmp              (char* str1, char* str2);

STATUS  ShowNavigationQuestionScreen  (char *text, int *answer);
STATUS  ShowNavigationBargraph        (void);
STATUS  StepBargraph                  (char *txt, int per);
STATUS  ClearScreen                   (void);
STATUS  UPGCDEject          (void);
STATUS  taskDelay           (int ticks);

void PL_itoa(int i,char* s,int base)
{
  char l_s[16];
  int  n=0,m=0;
  if( i<0 )
  {
    s[m++]='-';
    i=-i;
  }
  do
  {
    l_s[n++]=(char)('0'+(i%base));
    i/=base;
  }
  while( i );
  for( --n ; n>=0 ; n--,m++ )
    s[m]=l_s[n];
  s[m]=0;
}

/*** MAIN ***/

int main ( int argc, char **argv )
{
  char MessPL[256];
  char s_nb[16];

  char  l_sCmd[256];
  char  l_sText[256];
  char *l_pArgv[4];
  int   l_iAnsw;
  int   l_nFile;
  int   l_i;

  l_pArgv[0] = l_sCmd;
  l_pArgv[1] = argv[1];
  l_pArgv[2] = argv[2];
  l_pArgv[3] = NULL;

  // Builtins loading
  if ( NULL==LoadAndExecuteFile( argv[1],BUILTINS_FILE_NORMAL,LOAD_GLOBAL_SYMBOLS,ERROR,0 ) )
  {
    ShowNavigationQuestionScreen( "Erreur Chargement " BUILTINS_FILE_NORMAL, &l_iAnsw );
  }
  else
  {
    strcpy( l_sCmd,argv[1] );
    strcat( l_sCmd,DEF_CMD_DIR );
    ShowNavigationBargraph();
    StepBargraph( "Recherche des CMD..." ,0 );
    taskDelay(1000);

    //StepBargraph( l_sCmd ,0 );
    //taskDelay(1000);

    l_nFile = UPGSearchFile( "*.CMD",l_sCmd,NULL,NULL );
    if( l_nFile==0 )
    {
      ShowNavigationBargraph();
      StepBargraph( "0 CMD Trouvé !",100 );
      taskDelay(1000);
      ClearScreen();
    }
    else
    {
      if( l_nFile==1 )
      {
        ShowNavigationBargraph();
        StepBargraph( "1 CMD Trouvé !",100 );
        taskDelay(1000);
        ClearScreen();
      }
      else
      {
        PL_itoa(l_nFile,s_nb,10);
        strcpy(MessPL,s_nb);
        strcat(MessPL," CMD Trouvés !");
        ShowNavigationBargraph();
        StepBargraph( MessPL,100 );
        taskDelay(1000);
        ClearScreen();
      }

      for( l_i=0 ; l_i<l_nFile ; l_i++ )
      {
        if( UPGGetSearchResult( l_i,l_sCmd )!=ERROR )
        {
          if( strcmp( l_sCmd,argv[0] )==0 )
            continue;
  
          strcpy( l_sText,"On Lance " );
          strcat( l_sText,strrchr( l_sCmd,'/' )+1 );
          strcat( l_sText," ?" );
          ShowNavigationQuestionScreen( l_sText, &l_iAnsw );

          if( l_iAnsw==YES )
          {
            ShowCDIdentification();
            EiC_ExeFile( 3,l_pArgv );
            break;
          }
        }
      }
    }
  }
  ShowNavigationBargraph();
  StepBargraph( "Terminé !",100 );
  taskDelay(2000);
  ClearScreen();
  return OK;
}


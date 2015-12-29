
// ENVOIE 1 Fichier - > 16 Fichiers : Image.jpg -> Citroen.bmp, Premium_Citroen.bmp, les Peugeot, les SST et les .INF...

// Il SUFFIT de Placer dans la RACINE de la Clé USB le Fichier : Image.jpg (Il FAUT Respecter les Majuscules/Minuscules)

// Le CRC est Calculé et le Fichier .INF est Créé dans ce SCRIPT !

// Il sera Copié, ainsi que les .inf, dans TOUTES les Images d'Accueil du RT6...

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

int  CheckCRCFile(char *l_file);
int  UPGDelete(char * P_file);
int  UPGCopy(char *src,char *dst,int cut);
int  UPGGetSearchResult(int index , char *SearchResult);
int  GetFileSize(char* file, int* size);
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
void PL_itoa16( int i , char* s );

/*** MAIN ***/

int main ( int argc, char **argv )
{
	char carlu;
	char s_nb[16];
	char s_i[16];
	char CRC_FIC[16];
	char CRC_INF[16];
	char MessPL[256];
	int  nb;
	int  size_FIC;
	int  size_INF;
	int  answ;
	int  CRC;
	int  c1;
	int  c2;
	int  rg;
	int  i;
	int  j;
	FILE *l_fileIN;
	FILE *l_fileOUT;

	char l_line[20];

	int table_h[]= 
	{
	0x00, 0xdf, 0xbe, 0x61, 0x7c, 0xa3, 0xc2, 0x1d, 0xd3, 0x0c, 0x6d, 0xb2, 0xaf, 0x70, 0x11, 0xce,
	0x8d, 0x52, 0x33, 0xec, 0xf1, 0x2e, 0x4f, 0x90, 0x5e, 0x81, 0xe0, 0x3f, 0x22, 0xfd, 0x9c, 0x43,
	0x1a, 0xc5, 0xa4, 0x7b, 0x66, 0xb9, 0xd8, 0x07, 0xc9, 0x16, 0x77, 0xa8, 0xb5, 0x6a, 0x0b, 0xd4,
	0x97, 0x48, 0x29, 0xf6, 0xeb, 0x34, 0x55, 0x8a, 0x44, 0x9b, 0xfa, 0x25, 0x38, 0xe7, 0x86, 0x59,
	0x1f, 0xc0, 0xa1, 0x7e, 0x63, 0xbc, 0xdd, 0x02, 0xcc, 0x13, 0x72, 0xad, 0xb0, 0x6f, 0x0e, 0xd1,
	0x92, 0x4d, 0x2c, 0xf3, 0xee, 0x31, 0x50, 0x8f, 0x41, 0x9e, 0xff, 0x20, 0x3d, 0xe2, 0x83, 0x5c,
	0x05, 0xda, 0xbb, 0x64, 0x79, 0xa6, 0xc7, 0x18, 0xd6, 0x09, 0x68, 0xb7, 0xaa, 0x75, 0x14, 0xcb,
	0x88, 0x57, 0x36, 0xe9, 0xf4, 0x2b, 0x4a, 0x95, 0x5b, 0x84, 0xe5, 0x3a, 0x27, 0xf8, 0x99, 0x46,
	0x15, 0xca, 0xab, 0x74, 0x69, 0xb6, 0xd7, 0x08, 0xc6, 0x19, 0x78, 0xa7, 0xba, 0x65, 0x04, 0xdb,
	0x98, 0x47, 0x26, 0xf9, 0xe4, 0x3b, 0x5a, 0x85, 0x4b, 0x94, 0xf5, 0x2a, 0x37, 0xe8, 0x89, 0x56,
	0x0f, 0xd0, 0xb1, 0x6e, 0x73, 0xac, 0xcd, 0x12, 0xdc, 0x03, 0x62, 0xbd, 0xa0, 0x7f, 0x1e, 0xc1,
	0x82, 0x5d, 0x3c, 0xe3, 0xfe, 0x21, 0x40, 0x9f, 0x51, 0x8e, 0xef, 0x30, 0x2d, 0xf2, 0x93, 0x4c,
	0x0a, 0xd5, 0xb4, 0x6b, 0x76, 0xa9, 0xc8, 0x17, 0xd9, 0x06, 0x67, 0xb8, 0xa5, 0x7a, 0x1b, 0xc4,
	0x87, 0x58, 0x39, 0xe6, 0xfb, 0x24, 0x45, 0x9a, 0x54, 0x8b, 0xea, 0x35, 0x28, 0xf7, 0x96, 0x49,
	0x10, 0xcf, 0xae, 0x71, 0x6c, 0xb3, 0xd2, 0x0d, 0xc3, 0x1c, 0x7d, 0xa2, 0xbf, 0x60, 0x01, 0xde,
	0x9d, 0x42, 0x23, 0xfc, 0xe1, 0x3e, 0x5f, 0x80, 0x4e, 0x91, 0xf0, 0x2f, 0x32, 0xed, 0x8c, 0x53
	};

	int table_l[]= 
	{
	0x00, 0x2b, 0x57, 0x7c, 0xaf, 0x84, 0xf8, 0xd3, 0xf6, 0xdd, 0xa1, 0x8a, 0x59, 0x72, 0x0e, 0x25,
	0x45, 0x6e, 0x12, 0x39, 0xea, 0xc1, 0xbd, 0x96, 0xb3, 0x98, 0xe4, 0xcf, 0x1c, 0x37, 0x4b, 0x60,
	0x8b, 0xa0, 0xdc, 0xf7, 0x24, 0x0f, 0x73, 0x58, 0x7d, 0x56, 0x2a, 0x01, 0xd2, 0xf9, 0x85, 0xae,
	0xce, 0xe5, 0x99, 0xb2, 0x61, 0x4a, 0x36, 0x1d, 0x38, 0x13, 0x6f, 0x44, 0x97, 0xbc, 0xc0, 0xeb,
	0xbe, 0x95, 0xe9, 0xc2, 0x11, 0x3a, 0x46, 0x6d, 0x48, 0x63, 0x1f, 0x34, 0xe7, 0xcc, 0xb0, 0x9b,
	0xfb, 0xd0, 0xac, 0x87, 0x54, 0x7f, 0x03, 0x28, 0x0d, 0x26, 0x5a, 0x71, 0xa2, 0x89, 0xf5, 0xde,
	0x35, 0x1e, 0x62, 0x49, 0x9a, 0xb1, 0xcd, 0xe6, 0xc3, 0xe8, 0x94, 0xbf, 0x6c, 0x47, 0x3b, 0x10,
	0x70, 0x5b, 0x27, 0x0c, 0xdf, 0xf4, 0x88, 0xa3, 0x86, 0xad, 0xd1, 0xfa, 0x29, 0x02, 0x7e, 0x55,
	0xd4, 0xff, 0x83, 0xa8, 0x7b, 0x50, 0x2c, 0x07, 0x22, 0x09, 0x75, 0x5e, 0x8d, 0xa6, 0xda, 0xf1,
	0x91, 0xba, 0xc6, 0xed, 0x3e, 0x15, 0x69, 0x42, 0x67, 0x4c, 0x30, 0x1b, 0xc8, 0xe3, 0x9f, 0xb4,
	0x5f, 0x74, 0x08, 0x23, 0xf0, 0xdb, 0xa7, 0x8c, 0xa9, 0x82, 0xfe, 0xd5, 0x06, 0x2d, 0x51, 0x7a,
	0x1a, 0x31, 0x4d, 0x66, 0xb5, 0x9e, 0xe2, 0xc9, 0xec, 0xc7, 0xbb, 0x90, 0x43, 0x68, 0x14, 0x3f,
	0x6a, 0x41, 0x3d, 0x16, 0xc5, 0xee, 0x92, 0xb9, 0x9c, 0xb7, 0xcb, 0xe0, 0x33, 0x18, 0x64, 0x4f,
	0x2f, 0x04, 0x78, 0x53, 0x80, 0xab, 0xd7, 0xfc, 0xd9, 0xf2, 0x8e, 0xa5, 0x76, 0x5d, 0x21, 0x0a,
	0xe1, 0xca, 0xb6, 0x9d, 0x4e, 0x65, 0x19, 0x32, 0x17, 0x3c, 0x40, 0x6b, 0xb8, 0x93, 0xef, 0xc4,
	0xa4, 0x8f, 0xf3, 0xd8, 0x0b, 0x20, 0x5c, 0x77, 0x52, 0x79, 0x05, 0x2e, 0xfd, 0xd6, 0xaa, 0x81
	};

	i    = 0;
	j    = 0;
	size_FIC = 0;
	size_INF = 0;
	c1   = 0;
	c2   = 0;
	rg   = 0;
	CRC  = 0;

	ClearScreen();
	ShowNavigationBargraph();

	if ( PL_FileExists( "/bd0/Image.jpg" ) != TRUE )
	{
		strcpy ( MessPL , "Image.jpg ABSENT !" );
		StepBargraph( MessPL , 50 );
		taskDelay( 3000 );
		ClearScreen();
		return ERROR;
	}

	GetFileSize ( "/bd0/Image.jpg" , &size_FIC );

	strcpy ( MessPL , "Image.jpg Présent !" );
	StepBargraph( MessPL , 100 );
	taskDelay( 1000 );

	PL_itoa10 ( size_FIC , s_nb );
	strcpy ( MessPL , "Taille : " );
	strcat ( MessPL , s_nb );
	strcat ( MessPL , " Octets..." );
	StepBargraph( MessPL , 100 );
	taskDelay( 2000 );

	// Calcul du CRC du FICHIER...
	
	l_fileIN = fopen ( "/bd0/Image.jpg" , "r");

	if ( NULL == l_fileIN )
	{
		StepBargraph( "ERREUR Ouverture !" , 100);
		taskDelay( 3000 );

		StepBargraph( "Vous DEVEZ Placer..." , 25);
		taskDelay( 2000 );
		StepBargraph( "le Fichier : Image.jpg..." , 50);
		taskDelay( 2000 );
		StepBargraph( "de Dim.ensions : 800 x 480 pixels..." , 75);
		taskDelay( 2000 );
		StepBargraph( "dans la Racine de la Clé USB !" , 100);
		taskDelay( 2000 );
	}
	else
	{
		StepBargraph( "Ouverture OK !" , 0);
		taskDelay( 500 );

		StepBargraph( "Calcul du CRC..." , 0);
		taskDelay( 500 );

		c1 = 0;
		c2 = 0;
		rg = 0;

		for ( i = 0 ; i < size_FIC ; i++ )
		{
			fseek ( l_fileIN , i , 0 );
	
			if ( i % 4000 == 0 )
			{
				j = ( 100 * i ) / size_FIC ;
				StepBargraph( "Calcul du CRC..." , j );
				taskDelay( 100 );
			}

			if ( NULL == fgets ( l_line , 2 , l_fileIN ) )
			{
				PL_itoa10 ( i , s_i );
				strcpy ( MessPL , "ERREUR Lecture ! " );
				strcat ( MessPL , s_i );
				StepBargraph( MessPL , 0);
				taskDelay( 3000 );
				i = size_FIC;
			}
			else
			{
				nb = (int) l_line[0];

				if ( nb < 0 )
					nb += 256;
					
				rg = c1 ^ nb;
				c1 = c2 ^ table_h[rg];
				c2 = table_l[rg];
				
/*
				if ( i == 1 || i == 2 )
				{ 
					PL_itoa10 ( i , s_i );
					PL_itoa16 ( nb , s_nb );
					strcpy ( MessPL , s_i );
					strcat ( MessPL , " -> " );
					strcat ( MessPL , s_nb );
					StepBargraph( MessPL , 0);
					taskDelay( 500 );
				}
				if ( i == size_FIC - 2 || i == size_FIC - 1 )
				{ 
					PL_itoa10 ( i , s_i );
					PL_itoa16 ( nb , s_nb );
					strcpy ( MessPL , s_i );
					strcat ( MessPL , " -> " );
					strcat ( MessPL , s_nb );
					StepBargraph( MessPL , 100);
					taskDelay( 500 );
				}
*/
			}
		}
		fclose(l_fileIN);
	} 

	PL_itoa16 ( c1 , s_nb );
	if ( c1 < 16 )
	{
		strcpy ( CRC_FIC , "0" );
		strcat ( CRC_FIC , s_nb );
	}
	else
		strcpy ( CRC_FIC , s_nb );

	PL_itoa16 ( c2 , s_nb );
	if ( c2 < 16 )
	{
		strcat ( CRC_FIC , "0" );
		strcat ( CRC_FIC , s_nb );
	}
	else
		strcat ( CRC_FIC , s_nb );
	
	strcpy ( MessPL , "CRC Fichier = " );
	strcat ( MessPL , CRC_FIC );
	StepBargraph( MessPL , 100);
	taskDelay( 2000 );

	StepBargraph( "Création .INF..." , 0);
	taskDelay( 1000 );
			
	l_fileOUT = fopen ( "/bd0/Image.jpg.inf" , "w");

	if (NULL == l_fileOUT)
	{
		StepBargraph( "ERREUR Création .INF !" , 0);
		taskDelay( 3000 );
	}
	else
	{
		// Création du .INF...
		
		strcpy ( MessPL , CRC_FIC );
		fputs ( MessPL , l_fileOUT );
		fputs ( "\r\n",l_fileOUT );

		strcpy ( MessPL , "VER:10.05.17.15.56" );
		fputs ( MessPL , l_fileOUT );
		fputs ( "\r\n",l_fileOUT );

		strcpy ( MessPL , "TYPE:RELOCABLE" );
		fputs ( MessPL , l_fileOUT );
		fputs ( "\r\n",l_fileOUT );

		strcpy ( MessPL , "COMPRESSED:NO" );
		fputs ( MessPL , l_fileOUT );
		fputs ( "\r\n",l_fileOUT );

		strcpy ( MessPL , "SIZE:" );
		PL_itoa10 ( size_FIC , s_nb );
		strcat ( MessPL , s_nb );
		fputs ( MessPL , l_fileOUT );
		fputs ( "\r\n",l_fileOUT );

		strcpy ( MessPL , "ENTRY:NO" );
		fputs ( MessPL , l_fileOUT );
		fputs ( "\r\n",l_fileOUT );

		strcpy ( MessPL , "SUBVER:" );
		fputs ( MessPL , l_fileOUT );
		fputs ( "\r\n",l_fileOUT );
		
		fclose(l_fileOUT);

		StepBargraph( ".INF Créé !" , 100);
		taskDelay( 1000 );
		

		l_fileIN = fopen ( "/bd0/Image.jpg.inf" , "r");

		if ( NULL == l_fileIN )
		{
			StepBargraph( "ERREUR Ouverture .INF !" , 0);
			taskDelay( 3000 );
		}
		else
		{
			// Calcul du CRC du .INF...
			
			GetFileSize ( "/bd0/Image.jpg.inf" , &size_INF );

			strcpy ( MessPL , "Image.jpg.inf Présent !" );
			StepBargraph( MessPL , 100 );
			taskDelay( 1000 );

			PL_itoa10 ( size_INF , s_nb );
			strcpy ( MessPL , "Taille : " );
			strcat ( MessPL , s_nb );
			strcat ( MessPL , " Octets..." );
			StepBargraph( MessPL , 100 );
			taskDelay( 2000 );
	
			StepBargraph( "Ouverture .INF OK !" , 100);
			taskDelay( 1000 );

			StepBargraph( "Calcul du CRC .INF..." , 0);
			taskDelay( 1000 );

			c1 = 0;
			c2 = 0;
			rg = 0;

			for ( i = 0 ; i < size_INF ; i++ )
			{
				fseek ( l_fileIN , i , 0 );

				if ( i % 4000 == 0 )
				{
					j = ( 100 * i ) / size_INF ;
					StepBargraph( "Calcul du CRC..." , j );
					taskDelay( 100 );
				}

				if ( NULL == fgets ( l_line , 2 , l_fileIN ) )
				{
					PL_itoa10 ( i , s_i );
					strcpy ( MessPL , "ERREUR Lecture ! " );
					strcat ( MessPL , s_i );
					StepBargraph( MessPL , 0);
					taskDelay( 3000 );
					i = size_INF;
				}
				else
				{
					nb = (int) l_line[0];

					if ( nb < 0 )
						nb += 256;
						
					rg = c1 ^ nb;
					c1 = c2 ^ table_h[rg];
					c2 = table_l[rg];
					
				}
			}
			fclose(l_fileIN);

			PL_itoa16 ( c1 , s_nb );
			if ( c1 < 16 )
			{
				strcpy ( CRC_INF , "0" );
				strcat ( CRC_INF , s_nb );
			}
			else
				strcpy ( CRC_INF , s_nb );

			PL_itoa16 ( c2 , s_nb );
			if ( c2 < 16 )
			{
				strcat ( CRC_INF , "0" );
				strcat ( CRC_INF , s_nb );
			}
			else
				strcat ( CRC_INF , s_nb );
	
			strcpy ( MessPL , "CRC .INF = " );
			strcat ( MessPL , CRC_INF );
			StepBargraph( MessPL , 100);
			taskDelay( 2000 );
			
			// Reste à le Placer dans le .inf...

			StepBargraph( "Modification .INF..." , 0);
			taskDelay( 1000 );
					
			l_fileOUT = fopen ( "/bd0/Image.jpg.inf" , "w");

			if (NULL == l_fileOUT)
			{
				StepBargraph( "ERREUR Création .INF !" , 100);
				taskDelay( 3000 );
			}
			else
			{
				// Re-Création du .INF...
				
				strcpy ( MessPL , CRC_INF );
				strcat ( MessPL , CRC_FIC );
				fputs ( MessPL , l_fileOUT );
				fputs ( "\r\n",l_fileOUT );

				strcpy ( MessPL , "VER:10.05.17.15.56" );
				fputs ( MessPL , l_fileOUT );
				fputs ( "\r\n",l_fileOUT );

				strcpy ( MessPL , "TYPE:RELOCABLE" );
				fputs ( MessPL , l_fileOUT );
				fputs ( "\r\n",l_fileOUT );

				strcpy ( MessPL , "COMPRESSED:NO" );
				fputs ( MessPL , l_fileOUT );
				fputs ( "\r\n",l_fileOUT );

				strcpy ( MessPL , "SIZE:" );
				PL_itoa10 ( size_FIC , s_nb );
				strcat ( MessPL , s_nb );
				fputs ( MessPL , l_fileOUT );
				fputs ( "\r\n",l_fileOUT );

				strcpy ( MessPL , "ENTRY:NO" );
				fputs ( MessPL , l_fileOUT );
				fputs ( "\r\n",l_fileOUT );

				strcpy ( MessPL , "SUBVER:" );
				fputs ( MessPL , l_fileOUT );
				fputs ( "\r\n",l_fileOUT );
				
				fclose(l_fileOUT);

				StepBargraph( ".INF Modifié !" , 10);
				taskDelay( 1000 );
				
				// Si OK, on recopie les 2 Fichiers... vers 16 Fichiers...

				StepBargraph( "Vérification .INF..." , 20);
				taskDelay( 1000 );
				
				if ( CheckCRCFile( "/bd0/Image.jpg" ) == OK )
				{
					StepBargraph( ".INF Vérifié par RT6 !" , 30);
					taskDelay( 1000 );
					
					nb = 0;
		  			StepBargraph( "Copie en cours..." , 34);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/Citroen.bmp"                 , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 38);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/Citroen.bmp.inf"             , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 42);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/Premium_Citroen.bmp"                 , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 46);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/Premium_Citroen.bmp.inf"             , 0 ) == OK )
						nb++ ;
					
					StepBargraph( "Copie en cours..." , 50);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/SST_Citroen.bmp"             , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 54);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/SST_Citroen.bmp.inf"         , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 58);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/STT_Premium_Citroen.bmp"     , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 62);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/STT_Premium_Citroen.bmp.inf" , 0 ) == OK )
						nb++ ;

					StepBargraph( "Copie en cours..." , 67);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/Peugeot.bmp"                 , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 71);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/Peugeot.bmp.inf"             , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 75);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/Premium_Peugeot.bmp"         , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 79);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/Premium_Peugeot.bmp.inf"     , 0 ) == OK )
						nb++ ;
					
					StepBargraph( "Copie en cours..." , 84);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/STT_Peugeot.bmp"             , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 88);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/STT_Peugeot.bmp.inf"         , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 92);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg"     , "/SDC/Data_Base/Graphics/Logo/STT_Premium_Peugeot.bmp"     , 0 ) == OK )
						nb++ ;
					StepBargraph( "Copie en cours..." , 96);
					taskDelay( 125 );
					if ( UPGCopy ( "/bd0/Image.jpg.inf" , "/SDC/Data_Base/Graphics/Logo/STT_Premium_Peugeot.bmp.inf" , 0 ) == OK )
						nb++ ;
					
					PL_itoa10 ( nb , s_nb );
					strcpy ( MessPL , s_nb );
					
					if ( nb > 1 )
						strcat ( MessPL , " Fichiés Copiés !" );
					else
						strcat ( MessPL , " Fichié Copié !" );
					
					StepBargraph( MessPL , 100 );
					taskDelay( 2000 );
			
					StepBargraph( "ACCUEIL Installé !" , 100);
					taskDelay( 3000 );
					
					if ( nb > 0 )
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
				}
				else
				{
					StepBargraph( "ERREUR .INF INCORRECT !" , 100);
					taskDelay( 3000 );
				}
			}
		} 
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

void PL_itoa16 (int i , char* s)
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
		if ( i%16 < 10 )
			l_s[n++] = (char)('0'+(i%16));
		else
			l_s[n++] = (char)('a'+(i%16)-10);
		i /= 16;
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


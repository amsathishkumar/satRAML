/*
 *
 * %name:		bfsServerApi.x %
 * %version:		21 %
 * %cvtype:		rpcsrc %
 * %subsystem:		1 %
 * %state:		working %
 *
 * Description:	
 *
 *
 * %created_by:		phardie %
 * %date_created:	Mon Nov 15 10:17:31 1999 %
 *
 * %derived_by:		phardie %
 * %date_modified:	Mon Nov 15 10:17:31 1999 %
 *
 * @(#) %filespec: bfsServerApi.x,21 %  (%full_filespec:  bfsServerApi.x,21:rpcsrc:1 %)
 *
 * Copyright (C) 1992-1995 Scientific-Atlanta, Inc.
 *
 */

%#define RPC_SVC_FG

const MAX_SERVER_NAME = 15;
const MAX_FILE_NAME = 250;
const MAX_PATH_NAME = 254;
const MAX_EXTERNAL_PATH_NAME = 250;
const MAX_ERROR_STRING = 80;
const EOF_OFFSET = -1;

typedef long int BFSOffset;
typedef unsigned long int BFSLength;
typedef unsigned long int BFSSourceId;
typedef unsigned long int BFSResponse;
typedef unsigned long int BFSHandle;
typedef BFSHandle BFSServerHandle;
typedef BFSHandle BFSFileHandle;
typedef BFSHandle BFSDirectoryHandle;
typedef BFSHandle BFSLinkHandle;
typedef opaque Buffer<>;
typedef string BFSServerName<MAX_SERVER_NAME>;
typedef string BFSPath<MAX_PATH_NAME>;


const MAX= 500;

enum BFSError
{ 
	BFSNoError,
	BFSInternalError,
	BFSInvalidName,
	BFSUnauthorizedServer,
	BFSUnauthorizedSource,
	BFSAlreadyRegistered,
	BFSSystemServer,
	BFSInvalidServer,
	BFSInvalidOperationMode,
	BFSInvalidPath,
	BFSInvalidHandle,
	BFSInvalidRequestHandle,
	BFSInvalidMode,
	BFSDuplicate,
	BFSExistingElement,
	BFSInvalidSourceId,
	BFSPathOrFileNameTooLong
};

enum BFSHandleType
{
	BFSserverHandle,
	BFSdirectoryHandle,
	BFSfileHandle,
	BFSlinkHandle
};
      
enum BFSBoolean
{ 
	BFSFalse=0,
	BFSTrue
};

enum BFSOperationMode
{ 
	BFSOperationModeOneWay,
	BFSOperationModeTwoWay 
};

enum BFSRegistrationType
{ 
	BFSRegistrationTypeNormal,
	BFSRegistrationTypeRestart 
};

enum BFSMode
{ 
	BFSModeLocalDelivery,
	BFSModeBFSServerDelivery 
};

enum BFSOpenMode
{ 
	BFSOpenReadMode,
	BFSOpenWriteMode,
	BFSOpenWriteTruncate
};

struct RegServ
{ 
	string BFSName<MAX_SERVER_NAME>;
	enum BFSOperationMode bfsOperationMode;
	enum BFSRegistrationType bfsRegistrationType;
	BFSSourceId bfsSourceId;
};

struct CreateDir
{ 
	BFSHandle BFSServerHandle;
	BFSPath BFSPath; 
};

struct CreateLnk
{
	BFSHandle BFSHandle;
	string BFSExternalPath<MAX_EXTERNAL_PATH_NAME>;
	string BFSName<MAX_FILE_NAME>;
	BFSSourceId BFSSourceId;
};

struct ModifyLnk
{
	BFSHandle BFSLinkHandle;
	string BFSExternalPath<MAX_EXTERNAL_PATH_NAME>;
	string BFSName<MAX_FILE_NAME>;
};

struct bfsCopy
{
	BFSFileHandle BFSFileHandle;
	string BFSExternalPath<MAX_EXTERNAL_PATH_NAME>;
};

struct ModDir
{
	BFSDirectoryHandle BFSDirectoryHandle;
	string BFSName<MAX_FILE_NAME>;
};

struct CreateFile
{ 
	BFSHandle BFSHandle;
	string BFSName<MAX_FILE_NAME>;
	enum BFSMode bfsMode;
	BFSSourceId BFSSourceId;
};

struct ModFile
{
	BFSFileHandle BFSFileHandle;
	string BFSName<MAX_FILE_NAME>;
};

struct bfsOpen
{ 
	BFSFileHandle BFSFileHandle; 
	enum BFSOpenMode bfsOpenMode; 
}; 

struct bfsRead
{ 
	BFSFileHandle BFSFileHandle; 
	BFSOffset BFSOffset; 
	BFSLength BFSLength; 
}; 

struct bfsWrite
{ 
	BFSFileHandle BFSFileHandle; 
	BFSOffset BFSOffset; 
	Buffer Buffer; 
}; 

struct qrhandle
{
	string BFSName<MAX_PATH_NAME>;
	enum BFSOperationMode bfsOperationMode;
};

struct Servhandle
{ 
	BFSServerHandle BFSServerHandle;
	BFSError bfserror;
};

struct linkhandle
{
	BFSLinkHandle BFSLinkHandle;
	BFSError bfserror;
};

struct bfbool
{ 
	enum BFSBoolean bfsboolean; 
	enum BFSError bfserror;
};

struct dirhandle
{ 
	BFSDirectoryHandle BFSDirectoryHandle;
	BFSError bfserror;
};

struct filehandle
{
	BFSFileHandle BFSFileHandle;
	BFSError bfserror;
};

struct bfhand
{
	BFSHandle BFSHandle;
	BFSError bfserror;
};

struct RetServerstatus
{
	string BFSName<MAX_PATH_NAME>;
	enum BFSOperationMode bfsOperationMode;
	BFSSourceId bfsSourceId;
};
 
struct RetDirstatus
{
	BFSPath BFSPath; 
};
 
struct RetFilestatus
{
	BFSPath BFSPath; 
	enum BFSMode bfsMode;
	BFSSourceId bfsSourceId;
	BFSLength BFSLength;
};
 
struct RetLinkstatus
{
	BFSPath BFSPath; 
	BFSSourceId bfsSourceId;
};
 
union RetQrunion switch (int err)
{
	case 0:
		struct RetServerstatus retserverstatus;
	case 1:
		struct RetDirstatus retdirstatus;
	case 2:
		struct RetFilestatus retfilestatus;
	case 3:
		struct RetLinkstatus retlinkstatus;
};

struct retqrstatus
{
	RetQrunion retqrunion;
	enum BFSBoolean bfsboolean;
	enum BFSError bfserror;
};

struct retServhandle
{
	BFSServerHandle BFSServerHandle;
	BFSSourceId bfsSourceId;
	enum BFSOperationMode bfsOperationMode;
	enum BFSError bfserror;
};

struct BFSHandleInfo
{
	BFSHandle BFSHandle;
	enum BFSHandleType bfsHandleType;
	string BFSName<MAX_PATH_NAME>;
};


struct  qrbfbool
{
	enum BFSBoolean bfsboolean;
	enum BFSError bfserror;
	struct BFSHandleInfo BFSHandleInfoList<>;
};

struct retbfsread
{
	Buffer Buffer; 
	enum BFSBoolean bfsboolean;
	enum BFSError bfserror;
}; 

program BFSPROG
{
	version BFSVERS
	{
		/* server (de)registration functions */
        	Servhandle BFSREGISTERSERVER(RegServ) = 100;
        	bfbool BFSDEREGISTERSERVER(BFSServerHandle) = 101;

		/* directory functions */
        	dirhandle BFSCreateDirectory(CreateDir) = 200;
        	bfbool BFSMODIFYDIRECTORY(ModDir) = 201;
        	bfbool BFSDELETEDIRECTORY(BFSDirectoryHandle) = 202;

		/* file functions */
        	filehandle BFSCREATEFILE(CreateFile) = 300;
        	bfbool BFSMODIFYFILE(ModFile) = 301;
        	bfbool BFSDELETEFILE(BFSFileHandle) = 302;
        	bfhand BFSOPEN(bfsOpen) = 303;
        	retbfsread BFSREAD(bfsRead) = 304;
        	bfbool BFSWRITE(bfsWrite) = 305;
        	bfbool BFSCLOSE(BFSFileHandle) = 306;
        	bfbool BFSCOPY(bfsCopy) = 307;

		/* link functions */
        	linkhandle BFSCreateLink(CreateLnk) = 400;
        	bfbool BFSModifyLink(ModifyLnk) = 401;
        	bfbool BFSDeleteLink(BFSLinkHandle) = 402;

		/* query functions */
        	retServhandle BFSQUERYSERVER(BFSServerName) = 500;
        	retqrstatus BFSQUERYHANDLE(BFSHandle) = 501;
        	bfhand BFSQUERYPATH(BFSPath) = 502;
        	qrbfbool BFSQUERYHANDLELIST(BFSHandle) = 503;
	} = 3;
} = 0x20003001;


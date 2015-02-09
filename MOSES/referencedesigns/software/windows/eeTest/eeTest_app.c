/*******************************************************************************
Copyright (c) 2009 CTI, Connect Tech Inc. All Rights Reserved.

THIS IS THE UNPUBLISHED PROPRIETARY SOURCE CODE OF CONNECT TECH INC.
The copyright notice above does not evidence any actual or intended
publication of such source code.

This module contains Proprietary Information of Connect Tech, Inc
and should be treated as Confidential.
********************************************************************************
Project:		FreeForm/PCI-104
Module:			eeTest_app.c
Description:	wrapper for DSTest()
********************************************************************************
Date		Author	Modifications
--------------------------------------------------------------------------------
2008-06-04	MF		Created
2009-03-19	MF		Cleanup include file ordering
*******************************************************************************/

/*===============
  HEADERS
===============*/
#include "eeTest.h"

/*******************************************************************************
Function:		main
Description:	The main entry point
*******************************************************************************/
int main( void )
{
    RETURN_CODE			rc;
    PLX_DEVICE_OBJECT	Device;
	PLX_DEVICE_OBJECT*	pDevice;
    U8					BarIndex;
	U8					bVerbose = FALSE;
	boardInfo			bi;
    // Get the device....
	pDevice = &Device;
	strcpy(&bi.serialNum[0],"1001");
	bi.boardRev = 0; // Rev A
	bi.plxDeviceType = 0x9056;

	rc = GetAndOpenDevice(pDevice, bi.plxDeviceType);
	if (rc != ApiSuccess)
    {
        printf("*ERROR* - API failed, unable to open PLX Device, quitting tester\n");
        PlxSdkErrorDisplay(rc);
        exit(-1);
    }


    // Set PCI BAR to use
    BarIndex = 2;

	// Execute Test
	eeTest(pDevice, BarIndex, bVerbose, &bi);



    // Close the Device
    PlxPci_DeviceClose( &Device );

	CTIPause();

	if (rc != ApiSuccess)
		exit(-1);
	else
		exit(0);

}


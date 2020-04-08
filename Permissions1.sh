#!/usr/bin/env bash
#Permissions Scripts for Linux System Administration.
#-----------------------------------------------------
#\*********************INDEX***************************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#\-rw-------	:(600)	Only the owner has read and write permissions.                                                   \\
#\-rw-r--r--	:(644)	Only the owner has read and write permissions; the group and others have read only.               \\
#\-rwx------ :(700)	Only the owner has read, write, and execute permissions.                                             \\
#\rwxr-xr-x	:(755)	The owner has read, write, and execute permissions; the group and others have only read and execute. \\
#\rwx--x--x	:(711)	The owner has read, write, and execute permissions; the group and others have only execute.          \\
#\rw-rw-rw-	:(666)	Everyone can read and write to the file. (Be careful with these permissions.)                        \\
#\rwxrwxrwx	:(777)	Everyone can read, write, and execute. (Again, this permissions setting can be hazardous.)           \\
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
#Script Global Variables
file_path="INSERT FILE PATH HERE: ~/something/something/my_file"
#---------------------------------------------------------
#Policy Enforcement Variables:
curr-own="Current Owning USER OR ID"
curr-group="The current policy group of the owner"
#---------------------------------------------------------
new-owner="new USER or ID to give file ownership/permissions to"
new-group="The policy group of the new user"
#---------------------------------------------------------
filename="The name of the file to transfer ownership"
ref-file="Reference file name"

#Root of Directory to transfer ownership
root_toTranfer="some directory name or file path to GIVE"

#Change into the directory of the files of which permission to Edit.
cd $file_path

#Become the Administration Root User in the Root Environment
sudo su -

#Main Permissions Codes: <Write>:
#Review Policy Inded Above
chmod 600 $file_name #Recommended
# -> chmod 644 $file_name
# -> chmod 700 $file_name
# -> chmod 755 $file_name
# -> chmod 711 $file_name
# -> chmod 666 $file_name
# -> chmod 777 $file_name

#Change Permissions with Security Options
#This policy will ne enforced as: check that current owner and group is correct before transfering ownership to [new-owner]:[new-group]
chown --from=$curr-own:$curr-group $new-owner:$new-group $filename

#From a Reference FILE
chown --reference=$ref-file $filename

#Transfer Ownership of directory
chown -R $new-owner:$new-group $root_toTranfer

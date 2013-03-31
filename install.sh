##########CONFIG##########

HOSTNAME=""
TIMEZONE="UTC"

#Unprivileged User Account
USER_NAME="admin";
#Unprivileged User Password
USER_PASSWORD=""
#Public Key for User
USER_SSHKEY=""

#FTP User Account
FTP_USER_NAME="sites"
#FTP User Password
FTP_USER_PASSWORD=""
#FTP User Group
FTP_USERGROUP="sites"

#SSH Port
#SSHD_PORT="22"
#SSH Protocol
#SSHD_PROTOCOL="2"
#SSH Allowed Groups
#SSHD_GROUPS="sshusers"
#SSH Permit Root Login
#SSHD_PERMITROOT="No"
#SSH Password Authentication
#SSHD_PASSWORDAUTH="Yes"

#Usergroup to use for Admin Accounts
SUDO_USERGROUP="wheel"
#Passwordless Sudo
SUDO_PASSWORDLESS="Do Not Require Password" #Require Password, Do Not Require Password

##########END CONFIG##########
PWD=$(pwd)
SCRIPTPATH=$(readlink -f $0)
BASEDIR=$(dirname $SCRIPTPATH)

#http://www.linode.com/stackscripts/view/?StackScriptID=1
source $BASEDIR/include/StackScriptBashLib.sh

# Install and Configure Sudo
aptitude -y install sudo
cp /etc/sudoers /etc/sudoers.tmp
chmod 0640 /etc/sudoers.tmp
test "$SUDO_PASSWORDLESS" == "Do Not Require Password" && (echo "%`echo $SUDO_USERGROUP | tr '[:upper:]' '[:lower:]'` ALL = NOPASSWD: ALL" >> /etc/sudoers.tmp)
test "$SUDO_PASSWORDLESS" == "Require Password" && (echo "%`echo $SUDO_USERGROUP | tr '[:upper:]' '[:lower:]'` ALL = (ALL) ALL" >> /etc/sudoers.tmp)
chmod 0440 /etc/sudoers.tmp
mv /etc/sudoers.tmp /etc/sudoers


# Configure SSHD
#echo "Port $SSHD_PORT" > /etc/ssh/sshd_config.tmp
#echo "Protocol $SSHD_PROTOCOL" >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(HostKey .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(UsePrivilegeSeparation .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(KeyRegenerationInterval .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(ServerKeyBits .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(SyslogFacility .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(LogLevel .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(LoginGraceTime .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#echo "PermitRootLogin `echo $SSHD_PERMITROOT | tr '[:upper:]' '[:lower:]'`" >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(StrictModes .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(RSAAuthentication .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(PubkeyAuthentication .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(IgnoreRhosts .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(RhostsRSAAuthentication .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(HostbasedAuthentication .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(PermitEmptyPasswords .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(ChallengeResponseAuthentication .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#echo "PasswordAuthentication `echo $SSHD_PASSWORDAUTH | tr '[:upper:]' '[:lower:]'`" >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(X11Forwarding .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(X11DisplayOffset .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(PrintMotd .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(PrintLastLog .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(TCPKeepAlive .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(MaxStartups .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(AcceptEnv .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(Subsystem .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#sed -n 's/\(UsePAM .*\)/\1/p' < /etc/ssh/sshd_config >> /etc/ssh/sshd_config.tmp
#echo "AllowGroups `echo $SSHD_GROUPS | tr '[:upper:]' '[:lower:]'`" >> /etc/ssh/sshd_config.tmp
#chmod 0600 /etc/ssh/sshd_config.tmp
#mv /etc/ssh/sshd_config.tmp /etc/ssh/sshd_config
#touch /tmp/restart-ssh

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.tmp
# echo -e "\nPermitRootLogin `echo $SSHD_PERMITROOT | tr '[:upper:]' '[:lower:]'`" >> /etc/ssh/sshd_config.tmp
sudo sed -i 's/PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
# echo "PasswordAuthentication `echo $SSHD_PASSWORDAUTH | tr '[:upper:]' '[:lower:]'`" >> /etc/ssh/sshd_config.tmp
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
# echo "AllowGroups `echo $SSHD_GROUPS | tr '[:upper:]' '[:lower:]'`" >> /etc/ssh/sshd_config.tmp
chmod 0600 /etc/ssh/sshd_config.tmp
mv /etc/ssh/sshd_config.tmp /etc/ssh/sshd_config
touch /tmp/restart-ssh

# Create Groups
#groupadd $SSHD_GROUPS
groupadd $SUDO_USERGROUP

# Create User & Add SSH Key
USER_NAME_LOWER=`echo $USER_NAME | tr '[:upper:]' '[:lower:]'`
#useradd -m -s /bin/bash -G $SSHD_GROUPS,$SUDO_USERGROUP $USER_NAME_LOWER
useradd -m -s /bin/bash -G $SUDO_USERGROUP $USER_NAME_LOWER
echo "$USER_NAME_LOWER:$USER_PASSWORD" | sudo chpasswd
USER_HOME=`sed -n "s/$USER_NAME_LOWER:x:[0-9]*:[0-9]*:[^:]*:\(.*\):.*/\1/p" < /etc/passwd`
sudo -u $USER_NAME_LOWER mkdir $USER_HOME/.ssh
echo "$USER_SSHKEY" >> $USER_HOME/.ssh/authorized_keys
chmod 0600 $USER_HOME/.ssh/authorized_keys
chown $USER_NAME_LOWER:$USER_NAME_LOWER $USER_HOME/.ssh/authorized_keys

# Setup Hostname
echo $HOSTNAME > /etc/hostname

# Set Timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime


# Module Installations
aptitude -y install git screen yum vsftpd

# Config vsftpd
cp $BASEDIR/conf_files/vsftpd.conf /etc/vsftpd.conf
FTP_USER_NAME_LOWER=`echo $FTP_USER_NAME | tr '[:upper:]' '[:lower:]'`
groupadd $FTP_USERGROUP
useradd -m -g $FTP_USERGROUP $FTP_USER_NAME_LOWER
echo "$FTP_USER_NAME_LOWER:$FTP_USER_PASSWORD" | sudo chpasswd
FTP_USER_HOME=`sed -n "s/$FTP_USER_NAME_LOWER:x:[0-9]*:[0-9]*:[^:]*:\(.*\):.*/\1/p" < /etc/passwd`
sudo -u $FTP_USER_NAME_LOWER mkdir $FTP_USER_HOME/.ssh
touch $FTP_USER_HOME/.ssh/authorized_keys
chmod 0600 $FTP_USER_HOME/.ssh/authorized_keys
chown $FTP_USER_NAME_LOWER:$FTP_USER_NAME_LOWER $FTP_USER_HOME/.ssh/authorized_keys
sudo service vsftpd start

# Download Server Shield
git clone git://github.com/bluedragonz/server-shield.git /home/$USER_NAME/server-shield
sed -i.bak -e 's/yum --security/yum/g' /home/$USER_NAME/server-shield/sshield
chmod +x /home/$USER_NAME/server-shield/sshield
cp /home/$USER_NAME/server-shield/sshield /etc/init.d/sshield
chown -hR $USER_NAME /home/$USER_NAME/server-shield
#/etc/init.d/sshield start

# Download VladGh.com-LEMP
git clone git://github.com/vladgh/VladGh.com-LEMP.git /home/$USER_NAME/VladGh.com-LEMP
sed -i.bak -e 's/start-stop-daemon/\/sbin\/start-stop-daemon/g' /home/$USER_NAME/VladGh.com-LEMP/init_files/nginx
chown -hR $USER_NAME /home/$USER_NAME/VladGh.com-LEMP
# Replace nginx.conf, default site
cp $BASEDIR/conf_files/nginx.conf /home/$USER_NAME/VladGh.com-LEMP/conf_files/nginx.conf
cp $BASEDIR/conf_files/default /home/$USER_NAME/VladGh.com-LEMP/conf_files/default

# Install Webmin
echo -e "\ndeb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list
wget -P /root/ http://www.webmin.com/jcameron-key.asc
apt-key add /root/jcameron-key.asc
apt-get update
apt-get install webmin

# Install Glances
add-apt-repository ppa:arnaud-hartmann/glances-stable
apt-get update
apt-get install glances


# Restart Services
restartServices
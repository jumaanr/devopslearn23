# Documentation : https://www.jenkins.io/doc/book/installing/linux/
# VM Connection
ssh -i /c/lib/keys/vm-ubuntu-azdevops-test-eastus-01_key.pem admin-devops@52.249.192.224
# username : jenkins-admin / password : jenkins@2022
#reset password of jenkins : https://www.youtube.com/watch?v=vkezUwXr3ZQ

#check Ubuntu version
lsb_release -a

#update packages and install JDK
sudo apt install default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt upgrade
#install jenkins
sudo apt install jenkins
# You will get an error , solution is : https://stackoverflow.com/a/72344097/21975715
#Then repeat line number 10 and 13

#Allow ports
sudo ufw allow 8080

#Start Jenkins instance
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
sudo -s

#Check initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

#------------- Prepare the VM for build by Jenkins----------------#
sudo apt update
sudo apt install git
git --version

#Install .NET SDK
sudo wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update; \
    sudo apt-get install -y apt-transport-https && \
    sudo apt-get update && \
    sudo apt-get install -y dotnet-sdk-6.0

# check dotnet version
dotnet --version


#allow permissions to Jenkins directory
sudo systemctl stop Jenkins
sudo systemctl start Jenkins

sudo chmod -R a+rwx /var/lib/jenkins/  #This is like a home directory
sudo chmod -R a+rwx /tmp/NuGetScratch

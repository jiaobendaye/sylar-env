mkdir -p ~/lab/sylar_env
cd ~/lab/sylar_env

# get sylar-env-1.1.0-1.el7.x86_64.rpm
if [! -f sylar-env-1.1.0-1.el7.x86_64.rpm]; then
  echo "sylar-env-1.1.0-1.el7.x86_64.rpm not exist"
  exit 0
fi

#base
yum install -y boost-devel glibc-devel zlib-devel git \
  ncurses-c++-libs ncurses-compat-libs libaio  net-tools numactl-libs perl 

# glibc-static
wget http://mirror.centos.org/centos/8/PowerTools/x86_64/os/Packages/libxcrypt-static-4.1.1-4.el8.x86_64.rpm
wget http://mirror.centos.org/centos/8/PowerTools/x86_64/os/Packages/glibc-static-2.28-151.el8.x86_64.rpm

rpm -ivf glibc-static-2.28-151.el8.x86_64.rpm libxcrypt-static-4.1.1-4.el8.x86_64.rpm \
  sylar-env-1.1.0-1.el7.x86_64.rpm


#mysql5.7
wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.33-1.el7.x86_64.rpm-bundle.tar
tar zxvf mysql-5.7.33-1.el7.x86_64.rpm-bundle.tar && cd mysql-5.7.33-1.el7.x86_64.rpm-bundle
rpm -ivh mysql-community-common-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-devel-5.7.33-1.el7.x86_64.rpm
ln -s /usr/lib64/mysql/libmysqlclient.so.20.3.20 /usr/lib64/mysql/libmysqlclient_r.so

#openssl1.0.2k
wget http://www.openssl.org/source/openssl-1.0.2k.tar.gz 
tar zxvf openssl-1.0.2k.tar.gz && cd openssl-1.0.2k
./config --prefix=/usr/local/ssl --shared
make && make install
rm /usr/lib64/libssl.so && rm /usr/lib64/libcrypto.so
ln -s /usr/local/ssl/lib/libssl.so /usr/lib64/libssl.so 
ln -s /usr/local/ssl/lib/libcrypto.so /usr/lib64/libcrypto.so 
ln -s /usr/local/ssl/lib/libssl.so /usr/lib64/libssl.so.10 
ln -s /usr/local/ssl/lib/libcrypto.so /usr/lib64/libcrypto.so.10
echo "/usr/local/ssl/lib">>/etc/ld.so.conf 
echo "export OPENSSL_ROOT_DIR=/usr/local/ssl" >> /root/.bashrc
ldconfig 
echo "export PATH=$PATH:/apps/sylar/bin" >> /root/.bashrc
source /root/.bashrc

#build
cd  ~/lab
git clone https://github.com/sylar-yin/sylar.git
cd sylar && mkdir build && cd build
cmake .. && make


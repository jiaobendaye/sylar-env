mkdir -p ~/lab/sylar_env
cd ~/lab/sylar_env

# get sylar-env-1.1.0-1.el7.x86_64.rpm
if [! -f sylar-env-1.1.0-1.el7.x86_64.rpm]; then
  echo "sylar-env-1.1.0-1.el7.x86_64.rpm not exist"
  exit 0
fi

#base
yum install -y boost-devel glibc-devel glibc-static zlib-devel git \
  ncurses-c++-libs ncurses-compat-libs libaio  net-tools numactl-libs perl openssl-devel


rpm -ivf sylar-env-1.1.0-1.el7.x86_64.rpm


#mysql5.7
wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.33-1.el7.x86_64.rpm-bundle.tar
tar zxvf mysql-5.7.33-1.el7.x86_64.rpm-bundle.tar && cd mysql-5.7.33-1.el7.x86_64.rpm-bundle
rpm -ivh mysql-community-common-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.33-1.el7.x86_64.rpm
rpm -ivh mysql-community-devel-5.7.33-1.el7.x86_64.rpm
ln -s /usr/lib64/mysql/libmysqlclient.so.20.3.20 /usr/lib64/mysql/libmysqlclient_r.so

echo "export PATH=$PATH:/apps/sylar/bin" >> ~/.bashrc
source ~/.bashrc

#build
cd  ~/lab
git clone https://github.com/sylar-yin/sylar.git
cd sylar && mkdir build && cd build
cmake .. && make


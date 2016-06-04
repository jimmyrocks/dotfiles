script_pwd=`pwd`
install_esri='false'
config_params='--with-geos=yes --with-sqlite3 --with-spatialite --with-postgres --with-odbc --with-curl=/usr/bin/curl-config  --with-python'
mkdir -p $HOME/tmp
echo '---------------------------'
echo 'Installing gdal with FileGDB Support'
echo '---------------------------'
if [ $install_esri == "true" ]; then
  if [ `uname -m` == "x86_64" ]; then
    echo "Downloading FileGDB_API_1_3-64.tar.gz from ESRI"
    curl -o $HOME/tmp/FileGDB_API_1_3.tar.gz http://downloads2.esri.com/Software/FileGDB_API_1_3-64.tar.gz
  else
    echo "Downloading FileGDB_API_1_3-32.tar.gz from ESRI"
    curl -o $HOME/tmp/FileGDB_API_1_3.tar.gz http://downloads2.esri.com/Software/FileGDB_API_1_3-32.tar.gz
  fi

  echo '---------------------------'
  echo 'Extracting and setting params'
  echo '---------------------------'
  # http://hydrogeotools.blogspot.com/2013/07/install-gdal-with-file-gdb-and.html
  mkdir -p /usr/local/ # not sure why you wouldn't have this?
  tar -zxvf $HOME/tmp/FileGDB_API_1_3.tar.gz -C /usr/local/
  rm $HOME/tmp/FileGDB_API_1_3.tar.gz

  # Add the line to ldconfig
  if grep -Fxq "/usr/local/FileGDB_API/lib" /etc/ld.so.conf; then
    echo "/usr/local/FileGDB_API/lib" >> /etc/ld.so.conf
    ldconfig
  fi
   # Add the line to the config
   config_params=$config_params" --with-fgdb=/usr/local/FileGDB_API"
fi
echo '---------------------------'
echo 'Installing gdal'
echo '---------------------------'
# Get gdal!
sudo apt-get remove gdal-bin #In case you have an older verion
sudo apt-get -y install libsqlite3-dev libspatialite-dev libspatialite5 libpq-dev libpq5 libcurl3 subversion libcurl4-gnutls-dev python-all-dev
svn checkout https://svn.osgeo.org/gdal/trunk/gdal $HOME/tmp/gdal
# You can also download it from here: (will update this later)
#    http://download.osgeo.org/gdal/CURRENT/gdal-1.11.1.tar.gz
cd $HOME/tmp/gdal
./configure $config_params
make
make install
ldconfig
sudo ln -s /usr/lib/libproj.so.0 /usr/lib/libproj.so

# All done, run tests
echo '---------------------------'
echo 'Running Tests'
echo '---------------------------'
gdal-config --version
gdal-config --formats
ogrinfo --formats | grep 'FileGDB'

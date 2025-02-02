Install wine / python on wine without sudo (for docker)
=============================

|license| |maintenance| |Build Status|

.. |license| image:: https://img.shields.io/github/license/webcomics/pywine.svg
   :target: http://en.wikipedia.org/wiki/MIT_License
.. |maintenance| image:: https://img.shields.io/maintenance/yes/{last_update_yyyy}.svg
.. |Build Status| image:: https://travis-ci.org/bitranox/install_python_on_wine_and_travis.svg?branch=master
   :target: https://travis-ci.org/bitranox/install_python_on_wine_and_travis

- Scripts to install wine on linux

- Scripts to install 32/64 Bit Wine Machine

- Scripts to install python on 32/64 Bit Wine Machine

- Scripts to install Git on 32/64 Bit Wine Machine

- Scripts to install Powershell Core on 32/64 Bit Wine Machine

Tested under `Linux xenial, bionic, disco <https://travis-ci.org/bitranox/install_python_on_wine_and_travis>`_, automatic daily builds  and monitoring

----

- `Installation and Prerequisites`_
- `Install WINE`_
- `Set up Wine Machine`_
- `Install latest Python 3.7 on WINE`_
- `Install GIT on WINE`_
- `Install Powershell Core on WINE`_
- `Running Commands on Wine`_
- `Acknowledgements`_
- `Contribute`_
- `Report Issues <https://github.com/bitranox/lib_bash_wine/blob/master/ISSUE_TEMPLATE.md>`_
- `Pull Request <https://github.com/bitranox/lib_bash_wine/blob/master/PULL_REQUEST_TEMPLATE.md>`_
- `Code of Conduct <https://github.com/bitranox/lib_bash_wine/blob/master/CODE_OF_CONDUCT.md>`_
- `License`_

----

Installation and Prerequisites
------------------------------

Prerequisites:
    - Ubuntu xenial, bionic, disco or newer
    - xvfb Service installed and running for headless machines


.. code-block:: bash

    # local installation
    apt-get install git
    git clone https://github.com/BEEugene/lib_bash_wine.git /usr/local/lib_bash_wine
    chmod -R 0755 /usr/local/lib_bash_wine
    chmod -R +x /usr/local/lib_bash_wine/*.sh
    /usr/local/lib_bash_wine/install_or_update.sh

Install WINE
============

.. code-block:: bash


    # set the wine_version from Your command prompt
    export wine_release="stable"     # for wine release stable, somehow old
    export wine_release="devel"      # for wine release development, recommended
    export wine_release="staging"    # for wine release staging, the newest version, might be unstable

    # next step will install wine - after that You will be able to set up 32 and 64 Bit Wine Machines
    /usr/local/lib_bash_wine/001_000_install_wine.sh


Set up Wine Machine
===================

you can set up as many Wine Machines as You want, with different settings, by selecting different WINEPREFIX

The WINEPREFIX is the path to the Wine machine, defaults to /home/<user>/.wine



.. code-block:: bash

    # you can automatically overwrite old wineprefix (the old wine machine) by setting :
    # export overwrite_existing_wine_machine="True"
    # handle with care !

    #############################################
    # Install Wine Machine 1 (32 Bit)
    #############################################
    # set Wine Prefix for Machine 1 (32 Bit)
    export WINEPREFIX=${HOME}/wine/wine32_machine_01
    # set Architecture to 32 Bit
    export WINEARCH="win32"
    # set winetricks_windows_version to report, defaults to "win10"
    # possible values: win10, win2k, win2k3, win2k8, win31, win7, win8, win81, win95, win98, winxp
    export winetricks_windows_version="win10"
    # next step is to set up the wine machine
    /usr/local/lib_bash_wine/002_000_install_wine_machine.sh

    #############################################
    # Install Wine Machine 2 (64 Bit)
    #############################################
    # set Wine Prefix for Machine 2 (64 Bit)
    export WINEPREFIX=${HOME}/wine/wine64_machine_02
    # set Architecture to 64 Bit
    export WINEARCH="win64"
    # set winetricks_windows_version to report, defaults to "win10"
    # possible values: win10, win2k, win2k3, win2k8, win31, win7, win8, win81, win95, win98, winxp
    export winetricks_windows_version="win10"
    # next step is to set up the wine machine
    /usr/local/lib_bash_wine/002_000_install_wine_machine.sh


Install latest Python 3.7 on WINE
=================================

you should install a 32 Bit Python on a 32 Bit Wine Machine, and 64 Bit Python on a 64 Bit Wine Machine.
Other combinations will probably not work.
The path setting in the registry of the wine machine will be adapted to point to the python 3.7 directories
You CAN install different Python Versions on the same WINE Machine, although the paths will point to the version installed at last.

.. code-block:: bash

    #############################################
    # install python 3.7 32 Bit Version on Machine 1
    #############################################
    # set Wine Prefix for Machine 1 (32 Bit)
    export WINEPREFIX=${HOME}/wine/wine32_machine_01
    # next step is to install python 3.7 on the Wine Machine - WINEARCH is detected automatically
    /usr/local/lib_bash_wine/003_000_install_wine_python3_preinstalled.sh

    #############################################
    # install python 3.7 64 Bit Version on Machine 2
    #############################################
    # set Wine Prefix for Machine 2 (64 Bit)
    export WINEPREFIX=${HOME}/wine/wine64_machine_02
    # next step is to install python 3.7 on the Wine Machine - WINEARCH is detected automatically
    /usr/local/lib_bash_wine/003_000_install_wine_python3_preinstalled.sh


Install GIT on WINE
===================


.. code-block:: bash

    #############################################
    # install Git 32 Bit Version on Machine 1
    #############################################
    # set Wine Prefix for Machine 1 (32 Bit)
    export WINEPREFIX=${HOME}/wine/wine32_machine_01
    # next step is to install Git on the Wine Machine - WINEARCH is detected automatically
    /usr/local/lib_bash_wine/004_000_install_wine_git_portable.sh

    #############################################
    # install Git 64 Bit Version on Machine 2
    #############################################
    # set Wine Prefix for Machine 2 (64 Bit)
    export WINEPREFIX=${HOME}/wine/wine64_machine_02
    # next step is to install Git on the Wine Machine - WINEARCH is detected automatically
    /usr/local/lib_bash_wine/004_000_install_wine_git_portable.sh


Install Powershell Core on WINE
===============================


.. code-block:: bash

    #############################################
    # install Powershell Core 32 Bit Version on Machine 1
    #############################################
    # set Wine Prefix for Machine 1 (32 Bit)
    export WINEPREFIX=${HOME}/wine/wine32_machine_01
    # next step is to install Powershell Core 32 Bit on the Wine Machine  - WINEARCH is detected automatically
    /usr/local/lib_bash_wine/005_000_install_wine_powershell_core.sh

    #############################################
    # install Powershell Core 64 Bit Version on Machine 2
    #############################################
    # set Wine Prefix for Machine 2 (64 Bit)
    export WINEPREFIX=${HOME}/wine/wine64_machine_02
    # next step is to install Powershell Core 34 Bit on the Wine Machine  - WINEARCH is detected automatically
    /usr/local/lib_bash_wine/005_000_install_wine_powershell_core.sh


Running Commands on Wine
========================


.. code-block:: bash

    #############################################
    # Running Commands on Machine 1
    #############################################
    # set Wine Prefix for Machine 1 (32 Bit)
    export WINEPREFIX=${HOME}/wine/wine32_machine_01
    # test if it is working
    wine pip install --upgrade pip
    # alternatively a one-liner, handy for Icons:
    WINEPREFIX=${HOME}/wine/wine32_machine_01 wine pip install --upgrade pip
    # opening wineconsole
    wineconsole

    #############################################
    # Running Commands on Machine 2
    #############################################
    # set Wine Prefix for Machine 2 (64 Bit)
    export WINEPREFIX=${HOME}/wine/wine64_machine_02
    # test if it is working
    wine pip install --upgrade pip
    # alternatively a one-liner, handy for Icons:
    WINEPREFIX=${HOME}/wine/wine64_machine_02 wine pip install --upgrade pip
    # opening wineconsole
    wineconsole



Acknowledgements
----------------

- special thanks to "uncle bob" Robert C. Martin, especially for his books on "clean code" and "clean architecture"

Contribute
----------

I would love for you to fork and send me pull request for this project.
- `please Contribute <https://github.com/bitranox/lib_bash_wine/blob/master/CONTRIBUTING.md>`_

License
-------

This software is licensed under the `MIT license <http://en.wikipedia.org/wiki/MIT_License>`_


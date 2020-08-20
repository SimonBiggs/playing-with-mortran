
###############################################################################
#
#  EGSnrc mortran3 makefile
#  Copyright (C) 2015 National Research Council Canada
#
#  This file is part of EGSnrc.
#
#  EGSnrc is free software: you can redistribute it and/or modify it under
#  the terms of the GNU Affero General Public License as published by the
#  Free Software Foundation, either version 3 of the License, or (at your
#  option) any later version.
#
#  EGSnrc is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for
#  more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with EGSnrc. If not, see <http://www.gnu.org/licenses/>.
#
###############################################################################
#
#  Author:          Iwan Kawrakow, 2003
#
#  Contributors:    Frederic Tessier
#
###############################################################################

export MORTRAN_DATA = ./bin/mortran3.dat  
export MORTRAN_EXE = ./bin/mortran3.exe
export BUILD_DIR = ./build
export F77 = gfortran
export FCFLAGS = -fPIC
export FOPT = -O2 -mtune=native
export my_machine = linux
export FLIBS = 
export FOUT = -o 

export CHECK77_EXE = ./build/check77.exe
export PHYSICS_EXE = ./build/physics.exe

all: $(MORTRAN_DATA) $(MORTRAN_EXE)

$(MORTRAN_DATA): mornew77.raw $(MORTRAN_EXE)
	echo "Making mortran3.dat"
	$(MORTRAN_EXE) -s -d mornew77.raw -o7 $@ -o8 mornew77.lst

sources = mortran3.f ./lib/machine.f

$(MORTRAN_EXE): $(sources)
	echo "Compiling $(sources)"
	$(F77) $(FCFLAGS) $(FOPT) $(FOUT)$@ $(sources) $(FLIBS)


./build/%.exe : ./%.mortran
	$(MORTRAN_EXE) -s -d $(MORTRAN_DATA) -f $< -o7 $(BUILD_DIR)/temp.f -o8 $(BUILD_DIR)/temp.mortlst
	$(F77) $(FCFLAGS) $(FOPT) -o $@ $(BUILD_DIR)/temp.f $(FLIBS)

check: $(CHECK77_EXE)
	$(CHECK77_EXE)

physics: $(PHYSICS_EXE)
	$(PHYSICS_EXE)

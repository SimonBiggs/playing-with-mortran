
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

all: $(MORTRAN_DATA) $(MORTRAN_EXE)

$(MORTRAN_DATA): mornew77.raw $(MORTRAN_EXE)
	@echo "Making mortran3.dat"
	@$(MORTRAN_EXE) -s -d mornew77.raw -o7 $@ -o8 mornew77.lst

sources = mortran3.f  ./lib/machine.f

$(MORTRAN_EXE): $(sources)
	@echo "Compiling $(sources)"
	@$(F77) $(FCFLAGS) $(FOPT) $(FOUT)$@ $(sources) $(FLIBS)

check: fname = check77
check: $(out_exe)
	@echo $(out_exe)
	@echo "Running check77 test program"
	@$(out_exe)

$(out_exe): $(in_mortran) $(MORTRAN_DATA) $(MORTRAN_EXE)
	@echo "Mortran compiling check77 test program"
	@$(MORTRAN_EXE) -s -d $(MORTRAN_DATA) -f $(in_mortran) -o7 $(out_f) -o8 $(out_mortlst)
	@echo "Fortran compiling check77 test program"
	@$(F77) $(FCFLAGS) $(FOPT) -o $@ $(out_f) $(FLIBS)


export in_mortran = $(fname).mortran
export out_f = $(BUILD_DIR)/$(fname)_$(my_machine).f
export out_mortlst=$(BUILD_DIR)/$(fname)_$(my_machine).mortlst
export out_exe=$(BUILD_DIR)/$(fname)_$(my_machine).exe
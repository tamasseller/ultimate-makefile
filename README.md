Minimalist makefile "library" for single output C/C++ projects.
=====

The main goals are:

 - 🛠️ Maintainability: minimal possible complexity for ease of troubleshooting,
 - 🏆 No script generation: first-class build system implemented in pure make,
 - ⛓️ Portability: minimal dependence on external tooling,
 - 🏗️ Incremental building: dependency tracking to enable rebuilding only what is needed,
 - 📦 Modularity: incorporate internal dependencies for build-together libraries,
 - ⛴️ Deployment: automagic _install_ target according [GNU Makefile Conventions](https://www.gnu.org/software/make/manual/make.html#Install-Command-Categories) for ease of packaging automation.
 - ✨ Pretty output: add terminal coloring and hide build details for better readability.
 - 🔍 Unit test support: implement test coverage analysis for _check_ target

## Usage


It is supposed to be used like this:

 1. add ultimate-makefile repo as submodule,
 2. create application Makefile (e.g. based on the provided example), 
 3. fill in the parameters and provide overrides in the application Makefile,
 4. include Makefile.ultimate from the application Makefile.

## Provided targets

The following well-known make targets are provided.

### **all** (default)

Executes an incremental build aided by the dependency extraction mechanisms provided by the compiler. 
It is also the default target, thus invoking make without any arguments builds the main product (as it should).

### **check** (for test applications)

Run the output application with coverage analisys. Generates the report in HTML.

### **install** and **uninstall**

The **install** and **uninstall** targets provide means for system-wide deployment and removal of the program/library. 
They behave as expected:

 - The used commands can be defined externally as variables (CC, CXX, LD, AS, INSTALL, etc...)
 - The DESTDIR variable is prepended to install destinations to enable staged install (needed for packaging automation)
 - Determines the installation target directories based on the commonly used variables bindir, libdir, datadir, etc...
 - The *_INSTALL and *_UNINSTALL variables are used properly to enable pre- and post-install and uninstall operation extraction.
 - Recipies for the {pre,post}-{install,uninstall} targets can be provided by the application to carry out their respective tasks.
 
### **clean** and **mostlyclean**

The **mostlyclean** target removes all intermediate products, the **clean** target also removes the main product (the application or library).


 
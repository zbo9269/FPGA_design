# The package naming convention is <core_name>_xmdf
package provide DDR2_INTERFACE_ILA_xmdf 1.0

# This includes some utilities that support common XMDF operations
package require utilities_xmdf

# Define a namespace for this package. The name of the name space
# is <core_name>_xmdf
namespace eval ::DDR2_INTERFACE_ILA_xmdf {
# Use this to define any statics
}

# Function called by client to rebuild the params and port arrays
# Optional when the use context does not require the param or ports
# arrays to be available.
proc ::DDR2_INTERFACE_ILA_xmdf::xmdfInit { instance } {
# Variable containing name of library into which module is compiled
# Recommendation: <module_name>
# Required
utilities_xmdf::xmdfSetData $instance Module Attributes Name DDR2_INTERFACE_ILA
}
# ::DDR2_INTERFACE_ILA_xmdf::xmdfInit

# Function called by client to fill in all the xmdf* data variables
# based on the current settings of the parameters
proc ::DDR2_INTERFACE_ILA_xmdf::xmdfApplyParams { instance } {

set fcount 0
# Array containing libraries that are assumed to exist
# Examples include unisim and xilinxcorelib
# Optional
# In this example, we assume that the unisim library will
# be available to the simulation and synthesis tool
utilities_xmdf::xmdfSetData $instance FileSet $fcount type logical_library
utilities_xmdf::xmdfSetData $instance FileSet $fcount logical_library unisim
incr fcount


utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.asy
utilities_xmdf::xmdfSetData $instance FileSet $fcount type asy
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.cdc
utilities_xmdf::xmdfSetData $instance FileSet $fcount type AnyView
incr fcount


utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.constraints/DDR2_INTERFACE_ILA.ucf
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ignore
incr fcount


utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.constraints/DDR2_INTERFACE_ILA.xdc
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Xdc
incr fcount
utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.ncf
utilities_xmdf::xmdfSetData $instance FileSet $fcount type Ncf
incr fcount


utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.ngc
utilities_xmdf::xmdfSetData $instance FileSet $fcount type ngc
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.vhd
utilities_xmdf::xmdfSetData $instance FileSet $fcount type vhdl
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.vho
utilities_xmdf::xmdfSetData $instance FileSet $fcount type vhdl_template
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA.xco
utilities_xmdf::xmdfSetData $instance FileSet $fcount type coregen_ip
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount relative_path DDR2_INTERFACE_ILA_xmdf.tcl
utilities_xmdf::xmdfSetData $instance FileSet $fcount type AnyView
incr fcount

utilities_xmdf::xmdfSetData $instance FileSet $fcount associated_module DDR2_INTERFACE_ILA
incr fcount

}

# ::gen_comp_name_xmdf::xmdfApplyParams

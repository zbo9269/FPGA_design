################################################################################
##$Date: 2008/05/30 00:57:53 $
##$RCSfile: build_script_pl.ejava,v $
##$Revision: 1.1.2.1 $
################################################################################
##   ____  ____ 
##  /   /\/   / 
## /___/  \  /    Vendor: Xilinx 
## \   \   \/     Version : 1.5
##  \   \         Application : RocketIO GTX Wizard 
##  /   /         Filename : build_script.pl
## /___/   /\     Timestamp : 02/08/2005 09:12:43
## \   \  /  \ 
##  \___\/\___\ 
##
##
## MGT_WRAPPER BUILD SCRIPT
## Generated by Xilinx RocketIO GTX Wizard
##

#! /usr/bin/perl

    ##Check for required environment variables
    unless($xilinx_path = $ENV{XILINX})
    {
            print" XILINX environment variable has not been set.  This variable\n";
            print" points to your Xilinx ISE tools, and is required to run the mgt wrapper\n";
            print" scripts.\n";
            exit;
    }





    ##_____________________Set default values__________________________

    my $use_xst = 1;        # Default synthesis is xst
    my $use_synplify = 0;
    my $black_box = 0;
    my $no_synthesis = 0;
    my $no_ngdbuild = 0;
    my $no_map = 0;
    my $no_par = 0;
    my $no_bitgen = 0;
    my $use_ngc = 0;
    my $use_edf = 0;




    ##_____________________Read command line arguments_________________

    while( $option = shift @ARGV )
    {

        # -synplify                 : Select synplify as synthesis tool instead of default
        if($option =~ /^-synplify/)
        {
            $use_xst = 0;
            $use_synplify = 1;
        }


        # -xst                 : Select XST as synthesis tool instead of default
        if($option =~ /^-xst/)
        {
            $use_xst = 1;
            $use_synplify = 0;
        }


        # -nosynthesis             :   Don't run synthesis 
        #
        if($option =~ /^-nosynthesis/)
        {
            $no_synthesis  =   1;
        }


        # -nongdbuild             :    Don't run ngdbuild
        #                              
        if($option =~ /^-nongdbuild/)
        {
            $no_ngdbuild  =   1;
        }

        # -nomap                   :   Don't run map
        #                              
        if($option =~ /^-nomap/)
        {
            $no_map  =   1;
        }


        # -nopar                    :  Don't run par (place and route)
        #                              
        if($option =~ /^-nopar/)
        {
            $no_par  =   1;
        }
        
        
        # -nobitgen                    :  Don't run par (place and route)
        #                              
        if($option =~ /^-nobitgen/)
        {
            $no_bitgen  =   1;
        }


        # -h                        : this option produces a brief help message
        if($option =~ /^-h/)
        {
            show_help();
            exit;
        }

    }#next command line argument



    

    
    ##__________________________________Run Synthesis____________________________________
    if($no_synthesis == 0)
    {

        #Make a list of files that must be synthesized
        my @MODULES = (
                            "../src/mgt_usrclk_source_pll",
                            "../example/frame_gen",
                            "../example/frame_check",
                            "../src/pciegtx_wrapper_tile",
                            "../src/pciegtx_wrapper",
                            "../example/example_mgt_top"
                        ); #end MODULE list




        if($use_xst == 1)
        {
            #Create an XST project file
            open PRJ_FILE, ">example_mgt_top.prj";
            foreach $module (@MODULES)
            {
                print PRJ_FILE $module . ".vhd\n";
            }

            close PRJ_FILE;


            ##Create XST Script File

            open SCR_FILE, ">example_mgt_top.scr";
            print SCR_FILE "\n";
            print SCR_FILE "run\n";
            print SCR_FILE "-ifn example_mgt_top.prj\n";
            print SCR_FILE "-ifmt VHDL\n";
            print SCR_FILE "-ofn example_mgt_top.ngc\n";
            print SCR_FILE "-ofmt NGC\n";
            print SCR_FILE "-p xc5vfx30t-1ff665\n";
            print SCR_FILE "-top EXAMPLE_MGT_TOP\n";
            print SCR_FILE "-opt_mode Speed\n";
            print SCR_FILE "-opt_level 1\n";
            print SCR_FILE "-iuc NO\n";
            print SCR_FILE "-keep_hierarchy NO\n";
            print SCR_FILE "-glob_opt AllClockNets\n";
            print SCR_FILE "-rtlview Yes\n";
            print SCR_FILE "-read_cores YES\n";
            print SCR_FILE "-write_timing_constraints NO\n";
            print SCR_FILE "-cross_clock_analysis NO\n";
            print SCR_FILE "-hierarchy_separator /\n";
            print SCR_FILE "-bus_delimiter ()\n";
            print SCR_FILE "-case maintain\n";
            print SCR_FILE "-slice_utilization_ratio 100\n";
            print SCR_FILE "-fsm_extract YES\n";
            print SCR_FILE "-fsm_encoding Auto\n";
            print SCR_FILE "-ram_extract No\n";
            print SCR_FILE "-ram_style Auto\n";
            print SCR_FILE "-rom_extract No\n";
            print SCR_FILE "-rom_style Auto\n";
            print SCR_FILE "-mux_extract YES\n";
            print SCR_FILE "-mux_style Auto\n";
            print SCR_FILE "-decoder_extract YES\n";
            print SCR_FILE "-priority_extract YES\n";
            print SCR_FILE "-shreg_extract YES\n";
            print SCR_FILE "-shift_extract YES\n";
            print SCR_FILE "-xor_collapse YES\n";
            print SCR_FILE "-resource_sharing YES\n";
            print SCR_FILE "-mult_style auto\n";
            print SCR_FILE "-iobuf YES\n";
            print SCR_FILE "-max_fanout 500\n";
            print SCR_FILE "-bufg 16\n";
            print SCR_FILE "-register_duplication YES\n";
            print SCR_FILE "-equivalent_register_removal YES\n";
            print SCR_FILE "-register_balancing No\n";
            print SCR_FILE "-slice_packing YES\n";
            print SCR_FILE "-signal_encoding user\n";
            print SCR_FILE "-iob true\n";
            print SCR_FILE "-slice_utilization_ratio_maxmargin 5\n";
            close SCR_FILE;


            #Run xst
            system ("xst -ifn example_mgt_top.scr");

        }
        ##end if use_xst


        if($use_synplify == 1)
        {
            #Create a Synplify project file
            open  PRJ_FILE, ">example_mgt_top.prj";
            print PRJ_FILE "#Synplify project file for example_mgt_top\n";
            print PRJ_FILE "\n\n";
            
            foreach $module (@MODULES)
            {
                print PRJ_FILE "add_file -vhdl \"" . $module . ".vhd\"\n";
            }

            print PRJ_FILE "\n\n";
            print PRJ_FILE "project -result_file \"example_mgt_top.edf\"\n";
            print PRJ_FILE "set_option -top_module EXAMPLE_MGT_TOP\n";
            print PRJ_FILE "set_option -technology virtex5\n";

            print PRJ_FILE "set_option -part xc5vfx30t\n";
            print PRJ_FILE "set_option -package ff665\n";


            print PRJ_FILE "set_option -speed_grade -1\n";

            print PRJ_FILE "\n\n";
            print PRJ_FILE "#compilation/mapping options\n";
            print PRJ_FILE "set_option -default_enum_encoding default\n";
            print PRJ_FILE "set_option -symbolic_fsm_compiler 1\n";
            print PRJ_FILE "set_option -resource_sharing 1\n";

            print PRJ_FILE "\n";
            print PRJ_FILE "#map options\n";
            print PRJ_FILE "set_option -frequency 160.000\n";
            print PRJ_FILE "set_option -fanout_limit 100\n";
            print PRJ_FILE "set_option -disable_io_insertion 0\n";
            print PRJ_FILE "set_option -pipe 0\n";
            print PRJ_FILE "set_option -retiming 0\n";

            print PRJ_FILE "\n";
            print PRJ_FILE "#simulation options\n";
            print PRJ_FILE "set_option -write_verilog 0\n";
            print PRJ_FILE "set_option -write_vhdl 0\n";
            print PRJ_FILE "set_option -vlog_std v2001\n";

            print PRJ_FILE "\n";
            print PRJ_FILE "#Do not generate ncf constraints file\n";
            print PRJ_FILE "set_option -write_apr_constraint 0\n";

            close PRJ_FILE;


            #Run synplify_pro using the script
            
            unless($synplify_command = $ENV{SYNPLIFY_COMMAND})
            {
                $synplify_command = "synplify";
            }            
            
            print "### Running Synplify Pro - ";
            print "command is: <SYNPLIFY_COMMAND> -batch example_mgt_top.prj\n";
            print " where <SYNPLIFY_COMMAND> = ".$synplify_command."\n";
            print "\n";
            print "To customize <SYNPLIFY_COMMAND>, set the SYNPLIFY_COMMAND environment variable\n";
            print "\n\n";

            system ($synplify_command." -batch example_mgt_top.prj");
        }
        ##end if use_synplify
    
    }
    ##end synthesis section
    
    


    #_____________________________ Run ngdbuild __________________________________
    if($no_ngdbuild == 0)
    {

        $use_ngc  =   (-e "example_mgt_top.ngc");
        $use_edf  =   (-e "example_mgt_top.edf");


        if( $use_ngc && $use_edf )
        {
            #if there are 2 netlists available, ask user to delete one
            print "Its not clear which netlist you wish to use. Please delete or move either example_mgt_top.ngc\n";
                    print " or example_mgt_top.edf\n";
                    exit;
        }

        if( !$use_ngc && !$use_edf)
        {
            print "No netlist found\n";
            exit;
        }

        if($use_ngc == 1)
        {
            system ("ngdbuild -uc ../ucf/example_mgt_top.ucf -p xc5vfx30t-ff665-1 example_mgt_top.ngc example_mgt_top.ngd");
        }
        else
        {
            system ("ngdbuild -uc ../ucf/example_mgt_top.ucf -p xc5vfx30t-ff665-1 example_mgt_top.edf example_mgt_top.ngd");
        }
    }
    #end run ngdbuild section




    #_____________________________   Run map   ___________________________________
    if($no_map == 0)
    {
        system("map -p xc5vfx30t-ff665-1 -timing -o example_mgt_top_unrouted.ncd example_mgt_top.ngd example_mgt_top.pcf");
    }


    #_____________________________ Run par _______________________________________
    if($no_par == 0)
    {
        system("par -w -t 1 -ol high example_mgt_top_unrouted.ncd example_mgt_top.ncd example_mgt_top.pcf");
    }


    #______________________________ Report par results ___________________________
    if($no_bitgen == 0)
    {
        system("bitgen -d -g GWE_cycle:Done -g GTS_cycle:Done -g DriveDone:Yes -g StartupClk:Cclk -w example_mgt_top.ncd");
    }





#************************************ Subroutines **********************************************


    sub show_help
    {
        print"\nBUILD SCRIPT HELP\n\n";
        print"  build_script [options]\n\n";
        print"  Produces a bitstream for the mgt wrapper example design (example/example_mgt_top.vhd) using\n";
        print"  the Xilinx design implementation flow (synthesis -> ngdbuild -> map -> par -> bitgen )\n";
        print"options:\n\n";
        print"................................................................................\n\n";
        print" -synplify    Use the synplify tool from Synplicity to perform synthesis instead of XST\n\n";
        print" -h           Displays this message.  For more info, please see the RocketIO user\n";
        print"              guide.\n\n";
        print" -nosynthesis Skip the synthesis step. You must have valid ngc or edf netlists to run\n";
        print"              the next step (ngdbuild)\n\n";
        print" -nongdbuild  Skip ngdbuild. You must have a valid ngd file to run the\n";
        print"              next step (map)\n\n";
        print" -nomap       Skip map. You must have a valid unrouted ncd file and a valid\n";
        print"              pcf file to run the next step (par)\n";
        print" -nopar       Skip place and route. You must have a valid routed (post-par) ncd\n";
        print"              file to run the next step (bitgen)\n";
        print" -nobitgen    Skip bitgen. No bitfile will be produced for the design\n\n";
    }

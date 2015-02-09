
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name MOSES_DDR2_TestProject -dir "D:/MOSES/MOSES_Design/MOSES_DDR2_TestProject/planAhead_run_2" -part xc5vlx50tff665-1
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "D:/MOSES/MOSES_Design/MOSES_DDR2_TestProject/MOSES_DDR2_TestProject.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/MOSES/MOSES_Design/MOSES_DDR2_TestProject} {ipcore_dir} }
add_files [list {ipcore_dir/DDR2_ILA.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/ICON.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "MOSES_DDR2_TestProject.ucf" [current_fileset -constrset]
add_files [list {MOSES_DDR2_TestProject.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "D:/MOSES/MOSES_Design/MOSES_DDR2_TestProject/MOSES_DDR2_TestProject.ncd"
if {[catch {read_twx -name results_1 -file "D:/MOSES/MOSES_Design/MOSES_DDR2_TestProject/MOSES_DDR2_TestProject.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"D:/MOSES/MOSES_Design/MOSES_DDR2_TestProject/MOSES_DDR2_TestProject.twx\": $eInfo"
}
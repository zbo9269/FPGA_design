--*****************************************************************************
-- Copyright (c) 2007 Xilinx, Inc.
-- This design is confidential and proprietary of Xilinx, Inc.
-- All Rights Reserved
--*****************************************************************************
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: $Name: i+IP+131489 $
--  \   \         Application: MIG
--  /   /         Filename: mig20_phy_ctl_io_0.vhd
-- /___/   /\     Date Last Modified: $Date: 2007/09/21 15:23:31 $
-- \   \  /  \    Date Created: Wed Jan 10 2007
--  \___\/\___\
--
--Device: Virtex-5
--Design Name: DDR2
--Purpose:
--   This module puts the memory control signals like address, bank address,
--   row address strobe, column address strobe, write enable and clock enable
--   in the IOBs.
--Reference:
--Revision History:
--*****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;

entity mig20_phy_ctl_io_0 is
  generic (
    BANK_WIDTH     :     integer := 2;
    CKE_WIDTH      :     integer := 1;
    COL_WIDTH      :     integer := 10;
    CS_NUM         :     integer := 1;
    TWO_T_TIME_EN  :     integer := 0;
    CS_WIDTH       :     integer := 1;
    ODT_WIDTH      :     integer := 2;
    ROW_WIDTH      :     integer := 13;
    DDR_TYPE       :     integer := 1
    );
  port (
    clk0               : in  std_logic;
    clk90              : in  std_logic;
    rst0               : in  std_logic;
    rst90              : in  std_logic;
    ctrl_addr          : in  std_logic_vector(ROW_WIDTH-1 downto 0);
    ctrl_ba            : in  std_logic_vector(BANK_WIDTH-1 downto 0);
    ctrl_ras_n         : in  std_logic;
    ctrl_cas_n         : in  std_logic;
    ctrl_we_n          : in  std_logic;
    ctrl_cs_n          : in  std_logic_vector(CS_NUM-1 downto 0);
    phy_init_addr      : in  std_logic_vector(ROW_WIDTH-1 downto 0);
    phy_init_ba        : in  std_logic_vector(BANK_WIDTH-1 downto 0);
    phy_init_ras_n     : in  std_logic;
    phy_init_cas_n     : in  std_logic;
    phy_init_we_n      : in  std_logic;
    phy_init_cs_n      : in  std_logic_vector(CS_NUM-1 downto 0);
    phy_init_cke       : in  std_logic_vector(CKE_WIDTH-1 downto 0);
    phy_init_data_sel  : in  std_logic;
    odt                : in  std_logic;
    ddr_addr           : out std_logic_vector(ROW_WIDTH-1 downto 0);
    ddr_ba             : out std_logic_vector(BANK_WIDTH-1 downto 0);
    ddr_ras_n          : out std_logic;
    ddr_cas_n          : out std_logic;
    ddr_we_n           : out std_logic;
    ddr_cke            : out std_logic_vector(CKE_WIDTH-1 downto 0);
    ddr_cs_n           : out std_logic_vector(CS_WIDTH-1 downto 0);
    ddr_odt            : out std_logic_vector(ODT_WIDTH-1 downto 0)
    );
end entity mig20_phy_ctl_io_0;

architecture syn of mig20_phy_ctl_io_0 is

  signal addr_mux        : std_logic_vector(ROW_WIDTH-1 downto 0);
  signal ba_mux          : std_logic_vector(BANK_WIDTH-1 downto 0);
  signal cas_n_mux       : std_logic;
  signal cs_n_mux        : std_logic_vector(CS_NUM-1 downto 0);
  signal ras_n_mux       : std_logic;
  signal we_n_mux        : std_logic;


  attribute IOB : string;
  attribute IOB of u_ff_cas_n : label is "true";
  attribute IOB of u_ff_ras_n : label is "true";
  attribute IOB of u_ff_we_n  : label is "true";
  attribute syn_useioff : boolean;
  attribute syn_useioff of u_ff_cas_n : label is true;
  attribute syn_useioff of u_ff_ras_n : label is true;
  attribute syn_useioff of u_ff_we_n  : label is true;

begin

  --***************************************************************************



  -- MUX to choose from either PHY or controller for SDRAM control

  -- in 2t timing mode the extra register stage cannot be used.
  gen_two_t_0: if (TWO_T_TIME_EN /= 0) generate
    -- the control signals are asserted for two cycles
    process (ctrl_addr, ctrl_ba, ctrl_cas_n, ctrl_cs_n, ctrl_ras_n, ctrl_we_n,
             phy_init_addr, phy_init_ba, phy_init_cas_n, phy_init_cs_n,
             phy_init_ras_n, phy_init_we_n)
    begin
      if (phy_init_data_sel = '1') then
        addr_mux  <= ctrl_addr;
        ba_mux    <= ctrl_ba;
        cas_n_mux <= ctrl_cas_n;
        cs_n_mux  <= ctrl_cs_n;
        ras_n_mux <= ctrl_ras_n;
        we_n_mux  <= ctrl_we_n;
      else
        addr_mux  <= phy_init_addr;
        ba_mux    <= phy_init_ba;
        cas_n_mux <= phy_init_cas_n;
        cs_n_mux  <= phy_init_cs_n;
        ras_n_mux <= phy_init_ras_n;
        we_n_mux  <= phy_init_we_n;
      end if;
    end process;
  end generate;

  gen_two_t_1: if (TWO_T_TIME_EN = 0) generate
    -- register the signals in non 2t mode
    process (clk0)
    begin
      if (rising_edge(clk0)) then
        if (phy_init_data_sel = '1') then
          addr_mux  <= ctrl_addr;
          ba_mux    <= ctrl_ba;
          cas_n_mux <= ctrl_cas_n;
          cs_n_mux  <= ctrl_cs_n;
          ras_n_mux <= ctrl_ras_n;
          we_n_mux  <= ctrl_we_n;
        else
          addr_mux  <= phy_init_addr;
          ba_mux    <= phy_init_ba;
          cas_n_mux <= phy_init_cas_n;
          cs_n_mux  <= phy_init_cs_n;
          ras_n_mux <= phy_init_ras_n;
          we_n_mux  <= phy_init_we_n;
        end if;
      end if;
    end process;
  end generate;

  --***************************************************************************
  -- Output flop instantiation
  -- NOTE: Make sure all control/address flops are placed in IOBs
  --***************************************************************************

  -- RAS: = 1 at reset
  u_ff_ras_n : FDCPE
    port map (
      q    => ddr_ras_n,
      c    => clk0,
      ce   => '1',
      clr  => '0',
      d    => ras_n_mux,
      pre  => rst0
    );

  -- CAS: = 1 at reset
  u_ff_cas_n : FDCPE
    port map (
      q    => ddr_cas_n,
      c    => clk0,
      ce   => '1',
      clr  => '0',
      d    => cas_n_mux,
      pre  => rst0
    );

  -- WE: = 1 at reset
  u_ff_we_n : FDCPE
    port map (
      q    => ddr_we_n,
      c    => clk0,
      ce   => '1',
      clr  => '0',
      d    => we_n_mux,
      pre  => rst0
    );

  -- CKE: = 0 at reset
  gen_cke: for cke_i in 0 to CKE_WIDTH-1 generate
    attribute IOB of u_ff_cke   : label is "true";
    attribute syn_useioff of u_ff_cke : label is true;
  begin
    u_ff_cke : FDCPE
      port map (
        q    => ddr_cke(cke_i),
        c    => clk0,
        ce   => '1',
        clr  => rst0,
        d    => phy_init_cke(cke_i),
        pre  => '0'
      );
  end generate;

  -- chip select: = 1 at reset
  -- For unbuffered dimms the loading will be high. The chip select
  -- can be asserted early if the loading is very high. The
  -- code as is uses clock 0. If needed clock 270 can be used to
  -- toggle chip select 1/4 clock cycle early. The code has
  -- the clock 90 input for the early assertion of chip select.

  gen_cs_n: for cs_i in 0 to CS_WIDTH-1 generate
  begin
    gen_cs_two_t_0: if (TWO_T_TIME_EN /= 0) generate
      attribute IOB of u_ff_cs_n : label is "true";
      attribute syn_useioff of u_ff_cs_n : label is true;
    begin
      u_ff_cs_n : FDCPE
        port map (
          q    => ddr_cs_n(cs_i),
          c    => clk0,
          ce   => '1',
          clr  => '0',
          d    => cs_n_mux((cs_i * CS_NUM) / CS_WIDTH),
          pre  => rst0
        );
    end generate;
    gen_cs_two_t_1: if (TWO_T_TIME_EN = 0) generate
      attribute IOB of u_ff_cs_n : label is "true";
      attribute syn_useioff of u_ff_cs_n : label is true;
    begin
      u_ff_cs_n : FDCPE
        port map (
          q    => ddr_cs_n(cs_i),
          c    => clk0,
          ce   => '1',
          clr  => '0',
          d    => cs_n_mux((cs_i*CS_NUM)/CS_WIDTH),
          pre  => rst0
          );
    end generate;
  end generate;

  -- address: = X at reset
  -- (* IOB = "TRUE" *)
  gen_addr: for addr_i in 0 to ROW_WIDTH-1 generate
    attribute IOB of u_ff_addr : label is "true";
    attribute syn_useioff of u_ff_addr : label is true;
  begin
    u_ff_addr : FDCPE
      port map (
        q    => ddr_addr(addr_i),
        c    => clk0,
        ce   => '1',
        clr  => '0',
        d    => addr_mux(addr_i),
        pre  => '0'
        );
  end generate;

  -- bank address = X at reset
  gen_ba: for ba_i in 0 to BANK_WIDTH-1 generate
    attribute IOB of u_ff_ba : label is "true";
    attribute syn_useioff of u_ff_ba : label is true;
  begin
    u_ff_ba : FDCPE
      port map (
        q    => ddr_ba(ba_i),
        c    => clk0,
        ce   => '1',
        clr  => '0',
        d    => ba_mux(ba_i),
        pre  => '0'
        );
  end generate;

  -- ODT control = 0 at reset
  gen_odt_ddr2_ddr3: if (DDR_TYPE > 0) generate
    gen_odt: for odt_i in 0 to ODT_WIDTH-1 generate
      attribute IOB of u_ff_odt : label is "true";
      attribute syn_useioff of u_ff_odt : label is true;
    begin
      u_ff_odt : FDCPE
        port map (
          q    => ddr_odt(odt_i),
          c    => clk0,
          ce   => '1',
          clr  => rst0,
          d    => odt,
          pre  => '0'
        );
    end generate;
  end generate;

end architecture syn;


within ;
package INL_DT
  package Tests
    model NCFL_Modular

      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);
      //replaceable INL_DT.ControlSystems.TVC_CS CS constrainedby INL_DT.ControlSystems.RegularCS annotation(choicesAllMatching=true);

      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SecondaryLoop(
        redeclare package Medium = Medium,
        m_flow=20,
        nPorts=1,
        T=291.15)
        annotation (Placement(transformation(extent={{74,-16},{54,4}})));
      Components.NCFL ncfl(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare
          INL_DT.ControlSystems.Dynamic_CS CS)
        annotation (Placement(transformation(extent={{-62,-14},{-2,40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Medium,
        use_p_in=false,
        p=100000,
        T=291.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{42,42},{22,62}})));
    equation
      connect(SecondaryLoop.ports[1], ncfl.port_a) annotation (Line(points={{54,-6},
              {6,-6},{6,15.1},{-1.25,15.1}},    color={0,127,255}));
      connect(ncfl.port_b, boundary.ports[1]) annotation (Line(points={{-1.25,25},{16,
              25},{16,52},{22,52}},         color={0,127,255}));
      annotation (experiment(StartTime=0, StopTime=2500, Interval=0.1),
                                                                     Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end NCFL_Modular;

    model NCFL_Total
      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

      BaseClasses.Data_NCFL data(Heater_Length=1.5446375/3, Thermal_Cond=35)
        annotation (Placement(transformation(extent={{154,98},{174,118}})));
      Modelica.Fluid.Pipes.StaticPipe Slant(
        redeclare package Medium = Medium,
        length=data.Slant_Pipe_L,
        diameter=data.Pipe_D,
        height_ab=data.Slant,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01)
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Fluid.Pipes.StaticPipe Distance2Heaters(
        redeclare package Medium = Medium,
        length=0.6016625,
        diameter=data.Pipe_D,
        height_ab=0.6016625,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-64})));
      Modelica.Fluid.Pipes.StaticPipe PumpPipe(
        redeclare package Medium = Medium,
        length=1.252,
        diameter=data.Pipe_D,
        height_ab=0.3,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={70,-170})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
          Medium =
            Medium,
        use_input=true,
        m_flow_nominal=data.Pump_Mflow,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{46,-180},{26,-160}})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHX(
        redeclare package Medium = Medium,
        length=data.Height,
        diameter=data.Pipe_D,
        height_ab=-4,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-60})));
      replaceable package Medium_shell = Medium
        annotation (choicesAllMatching=true);
      replaceable package Medium_tube = Medium
        annotation (choicesAllMatching=true);

      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Medium,
        p_start=data.Init_P,
        T_start=data.Init_T,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
        nPorts_a=1,
        nPorts_b=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={86,-98})));

      NHES.Fluid.Sensors.stateSensor s1(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-96})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay
        annotation (Placement(transformation(extent={{-134,-112},{-80,-82}})));
      NHES.Fluid.Sensors.stateSensor s2(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,86})));
      NHES.Fluid.Sensors.stateSensor s3(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,64})));
      NHES.Fluid.Sensors.stateSensor s4(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-124})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay1
        annotation (Placement(transformation(extent={{-134,82},{-80,112}})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay2
        annotation (Placement(transformation(extent={{116,62},{170,92}})));
      NHES.Fluid.Sensors.stateDisplay stateDisplay3
        annotation (Placement(transformation(extent={{108,-110},{162,-80}})));
      Modelica.Fluid.Pipes.StaticPipe V1_Inlet(
        redeclare package Medium = Medium,
        length=0.1905,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={38,-142})));
      Modelica.Fluid.Valves.ValveIncompressible V_top(
        redeclare package Medium = Medium,
        dp_nominal=data.Init_P,
        m_flow_nominal=data.Pump_Mflow/2)
        annotation (Placement(transformation(extent={{12,-152},{-8,-132}})));
      Modelica.Fluid.Valves.ValveIncompressible V_bot(
        redeclare package Medium = Medium,
        dp_nominal=data.Init_P,
        m_flow_nominal=data.Pump_Mflow/2)
        annotation (Placement(transformation(extent={{4,-180},{-16,-160}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=stateDisplay1.T)
        annotation (Placement(transformation(extent={{-210,20},{-190,40}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=-stateDisplay.T)
        annotation (Placement(transformation(extent={{-210,-6},{-190,14}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-20,-60},{-26,-54}})));
      Modelica.Blocks.Math.Add T_diff
        annotation (Placement(transformation(extent={{-152,10},{-132,30}})));
      Modelica.Fluid.Pipes.StaticPipe JetInlet(
        redeclare package Medium = Medium,
        length=0.254,
        diameter=data.JetPump_D,
        height_ab=0.254,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-63,-158})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHeaters(
        redeclare package Medium = Medium,
        length=data.Height,
        diameter=data.Pipe_D,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,60})));
      Components.Heater heater3(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,30})));
      Components.Heater heater2(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,0})));
      Components.Heater heater1(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius,
        HeaterPower=data.Heater_Power) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,-34})));
      Modelica.Fluid.Pipes.StaticPipe JetSuction(
        redeclare package Medium = Medium,
        length=0.36195,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-142})));
      Modelica.Fluid.Pipes.StaticPipe ValveOutlet(
        redeclare package Medium = Medium,
        length=0.4572,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-170})));
      Modelica.Fluid.Pipes.StaticPipe JetPump(
        redeclare package Medium = Medium,
        length=data.JetPump_L,
        diameter=data.JetPump_D,
        height_ab=data.JetPump_L,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-65,-126})));
      Components.HX_Isolated HX(
        HXLength=data.HX_L,
        HXRadius=data.HX_radius,
        HX_Transfer=-10E3,
        Therm_cond=data.Thermal_Cond)
                           annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={88,26})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=-stateDisplay2.T)
        annotation (Placement(transformation(extent={{-212,-30},{-192,-10}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=stateDisplay3.T)
        annotation (Placement(transformation(extent={{-212,-56},{-192,-36}})));
      Modelica.Blocks.Math.Add T_diff1
        annotation (Placement(transformation(extent={{-154,-40},{-134,-20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Medium,
        p=data.Init_P,
        T=data.Init_T,
        nPorts=1)
        annotation (Placement(transformation(extent={{200,48},{180,68}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SecondaryLoop(
        redeclare package Medium = Medium,
        m_flow=20,
        nPorts=1)
        annotation (Placement(transformation(extent={{208,-16},{188,4}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=data.Pump_Mflow,
        duration=20,
        startTime=100)
        annotation (Placement(transformation(extent={{-20,-98},{-8,-86}})));
    equation
      connect(DistanceAfterHX.port_b, volume.port_a[1])
        annotation (Line(points={{86,-70},{86,-92}}, color={0,127,255}));
      connect(Distance2Heaters.port_a, s1.port_b)
        annotation (Line(points={{-64,-74},{-64,-86}},  color={0,127,255}));
      connect(s2.port_b, Slant.port_a) annotation (Line(points={{-64,96},{-64,100},
              {-10,100}}, color={0,127,255}));
      connect(Slant.port_b, s3.port_a)
        annotation (Line(points={{10,100},{86,100},{86,74}}, color={0,127,255}));
      connect(volume.port_b[1], s4.port_a)
        annotation (Line(points={{86,-104},{86,-114}}, color={0,127,255}));
      connect(s1.statePort, stateDisplay.statePort) annotation (Line(points={{-64.05,
              -95.95},{-52,-95.95},{-52,-108},{-70,-108},{-70,-120},{-107,-120},{-107,
              -100.9}},                                                     color=
             {0,0,0}));
      connect(s2.statePort, stateDisplay1.statePort) annotation (Line(points={{-64.05,
              86.05},{-64.05,98},{-78,98},{-78,76},{-107,76},{-107,93.1}}, color=
              {0,0,0}));
      connect(s3.statePort, stateDisplay2.statePort) annotation (Line(points={{
              85.95,63.95},{110,63.95},{110,56},{143,56},{143,73.1}}, color={0,0,
              0}));
      connect(s4.statePort, stateDisplay3.statePort) annotation (Line(points={{
              85.95,-124.05},{135,-124.05},{135,-98.9}}, color={0,0,0}));
      connect(V1_Inlet.port_a, s4.port_b) annotation (Line(points={{48,-142},{86,-142},
              {86,-134}}, color={0,127,255}));
      connect(V1_Inlet.port_b, V_top.port_a)
        annotation (Line(points={{28,-142},{12,-142}}, color={0,127,255}));
      connect(realExpression.y, T_diff.u1) annotation (Line(points={{-189,30},{
              -164,30},{-164,26},{-154,26}}, color={0,0,127}));
      connect(realExpression1.y, T_diff.u2) annotation (Line(points={{-189,4},{
              -162,4},{-162,14},{-154,14}}, color={0,0,127}));
      connect(DistanceAfterHeaters.port_b, s2.port_a)
        annotation (Line(points={{-64,70},{-64,76}}, color={0,127,255}));
      connect(heater3.port_b, DistanceAfterHeaters.port_a) annotation (Line(
            points={{-63.4,40},{-63.4,44},{-64,44},{-64,50}},
                                                          color={0,127,255}));
      connect(heater2.port_b, heater3.port_a)
        annotation (Line(points={{-63.4,10},{-63.4,16},{-63.2,16},{-63.2,20}},
                                                     color={0,127,255}));
      connect(Distance2Heaters.port_b, heater1.port_a) annotation (Line(points={{-64,-54},
              {-64,-48},{-63.2,-48},{-63.2,-44}},      color={0,127,255}));
      connect(heater1.port_b, heater2.port_a)
        annotation (Line(points={{-63.4,-24},{-63.4,-18},{-63.2,-18},{-63.2,-10}},
                                                       color={0,127,255}));
      connect(V_top.port_b, JetSuction.port_a)
        annotation (Line(points={{-8,-142},{-24,-142}}, color={0,127,255}));
      connect(JetInlet.port_a, ValveOutlet.port_b) annotation (Line(points={{-63,-168},
              {-63,-170},{-44,-170}}, color={0,127,255}));
      connect(ValveOutlet.port_a, V_bot.port_b)
        annotation (Line(points={{-24,-170},{-16,-170}}, color={0,127,255}));
      connect(JetInlet.port_b, JetPump.port_a) annotation (Line(points={{-63,-148},{
              -63,-144},{-65,-144},{-65,-136}}, color={0,127,255}));
      connect(JetSuction.port_b, JetPump.port_a) annotation (Line(points={{-44,-142},
              {-65,-142},{-65,-136}}, color={0,127,255}));
      connect(JetPump.port_b, s1.port_a) annotation (Line(points={{-65,-116},{-65,-111},
              {-64,-111},{-64,-106}}, color={0,127,255}));
      connect(pump.port_b, V_bot.port_a)
        annotation (Line(points={{26,-170},{4,-170}}, color={0,127,255}));
      connect(pump.port_a, PumpPipe.port_b)
        annotation (Line(points={{46,-170},{60,-170}}, color={0,127,255}));
      connect(PumpPipe.port_a, s4.port_b) annotation (Line(points={{80,-170},{86,-170},
              {86,-134}}, color={0,127,255}));
      connect(realExpression2.y, T_diff1.u1) annotation (Line(points={{-191,-20},
              {-166,-20},{-166,-24},{-156,-24}},
                                       color={0,0,127}));
      connect(realExpression3.y, T_diff1.u2) annotation (Line(points={{-191,-46},
              {-164,-46},{-164,-36},{-156,-36}},
                                             color={0,0,127}));
      connect(ramp.y, pump.in_m_flow) annotation (Line(points={{-7.4,-92},{22,
              -92},{22,-154},{20,-154},{20,-162.7},{36,-162.7}}, color={0,0,127}));
      connect(const.y, V_top.opening) annotation (Line(points={{-26.3,-57},{2,
              -57},{2,-134}}, color={0,0,127}));
      connect(const.y, V_bot.opening) annotation (Line(points={{-26.3,-57},{
              -26.3,-58},{2,-58},{2,-126},{18,-126},{18,-162},{-6,-162}}, color=
             {0,0,127}));
      connect(s3.port_b, HX.port_a_tube)
        annotation (Line(points={{86,54},{84,54},{84,36}}, color={0,127,255}));
      connect(DistanceAfterHX.port_a, HX.port_b_tube) annotation (Line(points={
              {86,-50},{84,-50},{84,16}}, color={0,127,255}));
      connect(HX.port_a_shell, SecondaryLoop.ports[1]) annotation (Line(points=
              {{89.8,16},{89.8,-6},{188,-6}}, color={0,127,255}));
      connect(HX.port_b_shell, boundary1.ports[1]) annotation (Line(points={{
              89.8,36},{89.8,44},{174,44},{174,42},{180,42},{180,58}}, color={0,
              127,255}));
      annotation (experiment(StartTime=0, StopTime=180, Interval=0.1), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
                -200},{300,120}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-220,-200},{300,
                120}})));
    end NCFL_Total;

    model HX_Boundary
      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);
      INL_DT.Components.HX_Isolated hX_Isolated
        annotation (Placement(transformation(extent={{-22,14},{-2,34}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SecondaryLoop(
        redeclare package Medium = Medium,
        m_flow=0.6,
        T=313.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Medium,
        use_p_in=false,
        p=100000,
        T=298.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-4},{-80,16}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Medium,
        use_p_in=false,
        p=100000,
        T=303.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{62,36},{42,56}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SecondaryLoop1(
        redeclare package Medium = Medium,
        m_flow=0.8,
        T=291.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{58,0},{38,20}})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Shell(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-62,48},{-42,68}})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Shell1(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Shell2(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{12,52},{32,72}})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Shell3(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{14,16},{34,36}})));
    equation
      connect(SecondaryLoop.ports[1], InletS_Shell.port) annotation (Line(
            points={{-80,44},{-56,44},{-56,42},{-52,42},{-52,48}}, color={0,127,
              255}));
      connect(InletS_Shell.port, hX_Isolated.port_a_shell) annotation (Line(
            points={{-52,48},{-52,36},{-28,36},{-28,25.8},{-22,25.8}}, color={0,
              127,255}));
      connect(hX_Isolated.port_b_shell, InletS_Shell2.port) annotation (Line(
            points={{-2,25.8},{8,25.8},{8,44},{22,44},{22,52}}, color={0,127,
              255}));
      connect(boundary1.ports[1], InletS_Shell2.port)
        annotation (Line(points={{42,46},{22,46},{22,52}}, color={0,127,255}));
      connect(SecondaryLoop1.ports[1], InletS_Shell3.port)
        annotation (Line(points={{38,10},{24,10},{24,16}}, color={0,127,255}));
      connect(hX_Isolated.port_a_tube, InletS_Shell3.port) annotation (Line(
            points={{-2,20},{8,20},{8,8},{24,8},{24,16}}, color={0,127,255}));
      connect(hX_Isolated.port_b_tube, InletS_Shell1.port) annotation (Line(
            points={{-22,20},{-36,20},{-36,4},{-50,4},{-50,12}}, color={0,127,
              255}));
      connect(InletS_Shell1.port, boundary.ports[1]) annotation (Line(points={{
              -50,12},{-50,6},{-80,6}}, color={0,127,255}));
    end HX_Boundary;

    model Sequence2_Modular

      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);
      //replaceable INL_DT.ControlSystems.TVC_CS CS constrainedby INL_DT.ControlSystems.RegularCS annotation(choicesAllMatching=true);

      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SecondaryLoop(
        redeclare package Medium = Medium,
        m_flow=0.55,
        nPorts=1,
        T=291.15)
        annotation (Placement(transformation(extent={{74,-16},{54,4}})));
      Components.NCFL ncfl(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare
          INL_DT.ControlSystems.Sequence2_Testing CS)
        annotation (Placement(transformation(extent={{-62,-14},{-2,40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Medium,
        use_p_in=false,
        p=100000,
        T=296.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{42,42},{22,62}})));
    equation
      connect(SecondaryLoop.ports[1], ncfl.port_a) annotation (Line(points={{54,-6},
              {6,-6},{6,15.1},{-1.25,15.1}},    color={0,127,255}));
      connect(ncfl.port_b, boundary.ports[1]) annotation (Line(points={{-1.25,25},{16,
              25},{16,52},{22,52}},         color={0,127,255}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StartTime=0,
          StopTime=3679,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end Sequence2_Modular;
  end Tests;

  package Components
    model Heater

      parameter Real bruh = 10;
      parameter Modelica.Units.SI.Length HeaterLength = 0;
      parameter Modelica.Units.SI.Length HeaterRadius = 0;
      parameter Modelica.Units.SI.Pressure Init_P = 101325;
      //parameter Modelica.Units.SI.Power HeaterPower = 0;
      parameter Boolean allowFlowReversal = false;



      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Heater(
        allowFlowReversal=false,
        redeclare package Medium = Medium,
        T_a_start=290.65,
        m_flow_a_start=0.04,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
            (crossAreas=fill(Modelica.Constants.pi*HeaterRadius^2, 1),
              perimeters=fill(Modelica.Constants.pi*2*HeaterRadius, 1)),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
            (m_flow_small=15),
        use_HeatTransfer=true) annotation (Placement(transformation(
            extent={{5,-5},{-5,5}},
            rotation=180,
            origin={-7,13})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow HeatSRC(use_port=
            true) annotation (Placement(transformation(
            extent={{5,5},{-5,-5}},
            rotation=-90,
            origin={-7,-9})));
      Modelica.Fluid.Pipes.StaticPipe HeaterPipe(
        redeclare package Medium = Medium,
        length=HeaterLength,
        diameter=HeaterRadius*2,
        p_a_start=Init_P,
        m_flow_start=0.04) annotation (Placement(transformation(
            extent={{4,-5},{-4,5}},
            rotation=180,
            origin={-33,12})));
      Modelica.Blocks.Interfaces.RealInput HeaterPower annotation (Placement(
            transformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={0,104}), iconTransformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={0,104})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,2},{-90,22}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{90,4},{110,24}})));
    equation
      connect(Heater.heatPorts[1, 1], HeatSRC.port)
        annotation (Line(points={{-7,10.5},{-7,-4}}, color={191,0,0}));
      connect(HeaterPipe.port_b, Heater.port_a)
        annotation (Line(points={{-29,12},{-29,13},{-12,13}}, color={0,127,255}));
      connect(port_a, HeaterPipe.port_a)
        annotation (Line(points={{-100,12},{-37,12}}, color={0,127,255}));
      connect(Heater.port_b, port_b) annotation (Line(points={{-2,13},{49,13},{
              49,14},{100,14}}, color={0,127,255}));
      connect(HeaterPower, HeatSRC.Q_flow_ext) annotation (Line(points={{0,104},
              {0,22},{2,22},{2,-18},{-7,-18},{-7,-11}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Heater;

    model JetPump
      parameter Modelica.Units.SI.Length SuctionRadius = 0;
      parameter Modelica.Units.SI.Length InletRadius = 0;
      parameter Modelica.Units.SI.Length DiffuserRadius = 0;
      parameter Boolean allowFlowReversal = false;

      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

      Modelica.Fluid.Interfaces.FluidPort_a InletPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_a SuctionPort
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b DischargePort
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Fluid.Pipes.StaticPipe Inlet annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-62})));
      Modelica.Fluid.Pipes.StaticPipe Suction annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={58,0})));
      Modelica.Fluid.Pipes.StaticPipe Nozzle annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,26})));
      Modelica.Fluid.Pipes.StaticPipe Diffuser annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,72})));
    equation
      connect(InletPort, Inlet.port_a) annotation (Line(points={{0,-100},{0,-86},{-5.55112e-16,
              -86},{-5.55112e-16,-72}}, color={0,127,255}));
      connect(SuctionPort, Suction.port_a) annotation (Line(points={{100,0},{84,0},{
              84,-1.72085e-15},{68,-1.72085e-15}}, color={0,127,255}));
      connect(Inlet.port_b, Nozzle.port_a) annotation (Line(points={{6.10623e-16,-52},
              {6.10623e-16,-18},{-5.55112e-16,-18},{-5.55112e-16,16}}, color={0,127,
              255}));
      connect(Suction.port_b, Nozzle.port_a) annotation (Line(points={{48,7.21645e-16},
              {-5.55112e-16,7.21645e-16},{-5.55112e-16,16}}, color={0,127,255}));
      connect(Nozzle.port_b, Diffuser.port_a) annotation (Line(points={{6.10623e-16,
              36},{6.10623e-16,49},{-5.55112e-16,49},{-5.55112e-16,62}}, color={0,127,
              255}));
      connect(Diffuser.port_b, DischargePort) annotation (Line(points={{6.10623e-16,
              82},{6.10623e-16,91},{0,91},{0,100}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end JetPump;

    model HX_Isolated

      parameter Modelica.Units.SI.Length HXLength = 0;
      parameter Modelica.Units.SI.Length HXRadius = 0;
      parameter Modelica.Units.SI.Pressure Init_P = 101325;
      parameter Modelica.Units.SI.Power HX_Transfer = 0;
      parameter Modelica.Units.SI.ThermalConductivity Therm_cond = 8E3;
      parameter Boolean allowFlowReversal = false;

      replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Shell(
        allowFlowReversal=false,
        redeclare package Medium = Medium,
        m_flow_a_start=0.04,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
            (crossAreas=fill(Modelica.Constants.pi*HXRadius^2, 1), perimeters=
                fill(Modelica.Constants.pi*2*HXRadius, 1)),
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal,
        redeclare model InternalHeatGen =
            TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
        annotation (Placement(transformation(
            extent={{5,-5},{-5,5}},
            rotation=180,
            origin={-7,21})));

      Modelica.Fluid.Pipes.StaticPipe HXPipe(
        redeclare package Medium = Medium,
        length=HXLength,
        diameter=HXRadius*2,
        p_a_start=Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{4,-5},{-4,5}},
            rotation=180,
            origin={-33,20})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_shell(redeclare package
          Medium = Medium, m_flow(min=if allowFlowReversal then -Modelica.Constants.inf
               else 0))
        annotation (Placement(transformation(extent={{-110,8},{-90,28}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_shell(redeclare package
          Medium = Medium, m_flow(max=if allowFlowReversal then +Modelica.Constants.inf
               else 0))
        annotation (Placement(transformation(extent={{90,8},{110,28}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder cylinder(
        L=HXLength,
        r_in=HXRadius,
        r_out=HXRadius + 0.02,
        lambda=Therm_cond) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-6,-8})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Tube(
        allowFlowReversal=false,
        redeclare package Medium = Medium,
        m_flow_a_start=0.04,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
            (crossAreas=fill(Modelica.Constants.pi*HXRadius^2, 1), perimeters=
                fill(Modelica.Constants.pi*2*HXRadius, 1)),
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal,
        redeclare model InternalHeatGen =
            TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
        annotation (Placement(transformation(
            extent={{-5,5},{5,-5}},
            rotation=180,
            origin={-7,-35})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_tube(redeclare package
          Medium = Medium, m_flow(min=if allowFlowReversal then -Modelica.Constants.inf
               else 0))
        annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_tube(redeclare package
          Medium = Medium, m_flow(max=if allowFlowReversal then +Modelica.Constants.inf
               else 0))
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      Modelica.Fluid.Pipes.StaticPipe HXTube(
        redeclare package Medium = Medium,
        length=HXLength,
        diameter=HXRadius*2,
        p_a_start=Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-4,-5},{4,5}},
            rotation=180,
            origin={-41,-34})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Shell(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
      TRANSFORM.Fluid.Sensors.Temperature OutletS_Shell(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{26,20},{46,40}})));
      TRANSFORM.Fluid.Sensors.Temperature OutletS_Tube(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-72,-34},{-52,-14}})));
      TRANSFORM.Fluid.Sensors.Temperature InletS_Tube(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{26,-36},{46,-16}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=InletS_Shell.T)
        annotation (Placement(transformation(extent={{-134,72},{-114,92}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=-OutletS_Shell.T)
        annotation (Placement(transformation(extent={{-134,46},{-114,66}})));
      Modelica.Blocks.Math.Add T_diff
        annotation (Placement(transformation(extent={{-76,62},{-56,82}})));
    equation
      connect(HXPipe.port_b, Shell.port_a) annotation (Line(points={{-29,20},{-29,
              21},{-12,21}}, color={0,127,255}));
      connect(port_a_shell, HXPipe.port_a) annotation (Line(points={{-100,18},{
              -98,18},{-98,20},{-37,20}}, color={0,127,255}));
      connect(Shell.heatPorts[1, 1], cylinder.port_a) annotation (Line(points={
              {-7,18.5},{-7,9.25},{-6,9.25},{-6,-1}}, color={191,0,0}));
      connect(Tube.heatPorts[1, 1], cylinder.port_b) annotation (Line(points={{
              -7,-32.5},{-7,-25.25},{-6,-25.25},{-6,-15}}, color={191,0,0}));
      connect(Tube.port_b, HXTube.port_a) annotation (Line(points={{-12,-35},{
              -24.5,-35},{-24.5,-34},{-37,-34}}, color={0,127,255}));
      connect(Tube.port_a, port_a_tube) annotation (Line(points={{-2,-35},{-2,-36},
              {84,-36},{84,-40},{100,-40}}, color={0,127,255}));
      connect(HXTube.port_b, port_b_tube) annotation (Line(points={{-45,-34},{-84,
              -34},{-84,-40},{-100,-40}}, color={0,127,255}));
      connect(port_a_shell, InletS_Shell.port) annotation (Line(points={{-100,
              18},{-98,18},{-98,20},{-60,20}}, color={0,127,255}));
      connect(Shell.port_b, OutletS_Shell.port) annotation (Line(points={{-2,21},
              {17,21},{17,20},{36,20}}, color={0,127,255}));
      connect(OutletS_Shell.port, port_b_shell) annotation (Line(points={{36,20},
              {36,18},{100,18}}, color={0,127,255}));
      connect(HXTube.port_b, OutletS_Tube.port)
        annotation (Line(points={{-45,-34},{-62,-34}}, color={0,127,255}));
      connect(Tube.port_a, InletS_Tube.port) annotation (Line(points={{-2,-35},
              {-2,-36},{36,-36}}, color={0,127,255}));
      connect(realExpression.y,T_diff. u1) annotation (Line(points={{-113,82},{
              -88,82},{-88,78},{-78,78}},    color={0,0,127}));
      connect(realExpression1.y,T_diff. u2) annotation (Line(points={{-113,56},
              {-86,56},{-86,66},{-78,66}},  color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end HX_Isolated;

    model JetPump_Claude
      "Physical jet pump (ejector) model with nozzle, mixing chamber, and diffuser"

      // ── Medium ──────────────────────────────────────────────────────────────
      replaceable package Medium = Modelica.Media.Water.StandardWater
        constrainedby Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);

      // ── Fluid ports ─────────────────────────────────────────────────────────
      Modelica.Fluid.Interfaces.FluidPort_a port_motive(
        redeclare package Medium = Medium)
        "Motive (primary, high-pressure) inlet"
        annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));

      Modelica.Fluid.Interfaces.FluidPort_a port_suction(
        redeclare package Medium = Medium)
        "Suction (secondary, low-pressure) inlet"
        annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));

      Modelica.Fluid.Interfaces.FluidPort_b port_discharge(
        redeclare package Medium = Medium)
        "Discharge (combined flow) outlet"
        annotation(Placement(transformation(extent={{90,-10},{110,10}})));

      // ── Geometry parameters ─────────────────────────────────────────────────
      parameter Modelica.Units.SI.Diameter d_nozzle =   0.020
        "Motive nozzle exit diameter";
      parameter Modelica.Units.SI.Diameter d_throat =    0.030
        "Mixing chamber (throat) diameter";
      parameter Modelica.Units.SI.Diameter d_diffuser =  0.050
        "Diffuser outlet diameter";
      parameter Modelica.Units.SI.Length   L_mixing =    0.150
        "Mixing chamber length";
      parameter Modelica.Units.SI.Length   L_diffuser =  0.300
        "Diffuser length";
      parameter Modelica.Units.SI.Angle    alpha_diff =  0.122
        "Diffuser half-angle [rad] (~7 deg)";

      // ── Loss coefficients ────────────────────────────────────────────────────
      parameter Real Cd_nozzle =  0.95  "Motive nozzle discharge coefficient [-]";
      parameter Real Kp =         0.05  "Primary nozzle loss coefficient [-]";
      parameter Real Ks =         0.10  "Suction inlet loss coefficient [-]";
      parameter Real Km =         0.15  "Mixing chamber loss coefficient [-]";
      parameter Real Kd =         0.20  "Diffuser loss coefficient [-]";

      // ── Derived geometry ─────────────────────────────────────────────────────
      final parameter Modelica.Units.SI.Area A_nozzle=
          Modelica.Constants.pi / 4 * d_nozzle^2   "Nozzle exit area";
      final parameter Modelica.Units.SI.Area A_throat=
          Modelica.Constants.pi / 4 * d_throat^2   "Throat (mixing) area";
      final parameter Modelica.Units.SI.Area A_diff_out=
          Modelica.Constants.pi / 4 * d_diffuser^2 "Diffuser outlet area";
      final parameter Real R = A_nozzle / A_throat  "Nozzle-to-throat area ratio";

      // ── Internal state variables ─────────────────────────────────────────────
      // --- Pressures ---
      Modelica.Units.SI.Pressure Pp(start=5e5)  "Motive inlet pressure";
      Modelica.Units.SI.Pressure Ps(start=1e5)  "Suction inlet pressure";
      Modelica.Units.SI.Pressure Pd(start=2e5)  "Discharge pressure";
      Modelica.Units.SI.Pressure P_throat(start=0.8e5) "Throat static pressure";

      // --- Enthalpies ---
      Modelica.Units.SI.SpecificEnthalpy hp "Motive specific enthalpy";
      Modelica.Units.SI.SpecificEnthalpy hs "Suction specific enthalpy";
      Modelica.Units.SI.SpecificEnthalpy hd "Discharge specific enthalpy";

      // --- Densities ---
      Modelica.Units.SI.Density rhop "Motive fluid density";
      Modelica.Units.SI.Density rhos "Suction fluid density";
      Modelica.Units.SI.Density rhom "Mixed fluid density at throat";

      // --- Mass flow rates (positive = into component) ---
      Modelica.Units.SI.MassFlowRate m_motive   "Motive mass flow rate";
      Modelica.Units.SI.MassFlowRate m_suction  "Suction mass flow rate";
      Modelica.Units.SI.MassFlowRate m_discharge "Discharge mass flow rate";

      // --- Velocities ---
      Modelica.Units.SI.Velocity v_nozzle   "Motive jet velocity at nozzle exit";
      Modelica.Units.SI.Velocity v_suction  "Suction flow velocity at throat entry";
      Modelica.Units.SI.Velocity v_throat   "Mixed flow velocity in throat";
      Modelica.Units.SI.Velocity v_diffuser "Mixed flow velocity at diffuser inlet";

      // --- Dimensionless performance ratios ---
      Real M(start=0.5)  "Flow ratio  Qs/Qp  (suction / motive volumetric flow)";
      Real N(start=0.3)  "Pressure ratio  (Pd-Ps)/(Pp-Pd)";
      Real C             "Density ratio  rhos/rhop";

      // --- Sub-component pressure drops ---
      Modelica.Units.SI.PressureDifference dP_nozzle   "Nozzle pressure drop";
      Modelica.Units.SI.PressureDifference dP_mixing   "Mixing chamber loss";
      Modelica.Units.SI.PressureDifference dP_diffuser "Diffuser pressure recovery";

      // ── System object (gravity, p_ambient, T_ambient) ────────────────────────
      outer Modelica.Fluid.System system;

    protected
      Medium.ThermodynamicState state_p  "Motive fluid thermodynamic state";
      Medium.ThermodynamicState state_s  "Suction fluid thermodynamic state";
      Medium.ThermodynamicState state_d  "Discharge fluid thermodynamic state";

    equation
      // ═══════════════════════════════════════════════════════════════════════
      // 1. PORT CONNECTIONS – pressures and sign conventions
      // ═══════════════════════════════════════════════════════════════════════
      Pp = port_motive.p;
      Ps = port_suction.p;
      Pd = port_discharge.p;

      // Inflow positive for motive and suction; outflow positive for discharge
      m_motive   =  port_motive.m_flow;
      m_suction  =  port_suction.m_flow;
      m_discharge= -port_discharge.m_flow;

      // ═══════════════════════════════════════════════════════════════════════
      // 2. THERMODYNAMIC STATES  (using inStream for upwind enthalpies)
      // ═══════════════════════════════════════════════════════════════════════
      hp = inStream(port_motive.h_outflow);
      hs = inStream(port_suction.h_outflow);

      state_p = Medium.setState_phX(Pp, hp, inStream(port_motive.Xi_outflow));
      state_s = Medium.setState_phX(Ps, hs, inStream(port_suction.Xi_outflow));

      rhop = Medium.density(state_p);
      rhos = Medium.density(state_s);

      // ═══════════════════════════════════════════════════════════════════════
      // 3. MASS BALANCE
      // ═══════════════════════════════════════════════════════════════════════
      m_discharge = m_motive + m_suction;          // continuity
      port_motive.m_flow + port_suction.m_flow + port_discharge.m_flow = 0;

      // ═══════════════════════════════════════════════════════════════════════
      // 4. NOZZLE  – converts motive pressure head → jet velocity
      //    Bernoulli + discharge coefficient
      //    v_nozzle = Cd * sqrt(2*(Pp - P_throat)/rhop)
      // ═══════════════════════════════════════════════════════════════════════
      dP_nozzle = Pp - P_throat;
      v_nozzle  = Cd_nozzle * sqrt(max(2 * dP_nozzle / rhop, 0));
      m_motive  = rhop * A_nozzle * v_nozzle;      // motive flow from nozzle orifice

      // ═══════════════════════════════════════════════════════════════════════
      // 5. SUCTION INLET – low-pressure side drawn in by throat vacuum
      //    Orifice equation with suction loss coefficient Ks
      // ═══════════════════════════════════════════════════════════════════════
      m_suction = rhos * (A_throat - A_nozzle) *
                  sqrt(max(2 * (Ps - P_throat) / (rhos * (1 + Ks)), 1e-6));

      // ═══════════════════════════════════════════════════════════════════════
      // 6. MIXING CHAMBER  – momentum balance in throat
      //    (rhop*Ap*vp^2 + rhos*As*vs^2) + A_throat*(Ps - Pd_throat) = (rhom*Am*vm^2)
      //    Simplified via dimensionless ratios (ESDU 85032 Cunningham formulation)
      // ═══════════════════════════════════════════════════════════════════════
      C = rhos / rhop;
      M = (m_suction / rhos) / (m_motive  / rhop);   // volumetric flow ratio

      rhom    = (m_motive + m_suction) / (m_motive/rhop + m_suction/rhos);
      v_throat   = m_discharge / (rhom * A_throat);
      v_suction  = m_suction   / (rhos * (A_throat - A_nozzle));
      v_diffuser = v_throat;                           // constant-area mixing assumed

      // Momentum equation → throat pressure
      // P_throat + rhom*v_throat^2 = Pp_eff + losses
      dP_mixing = Km * 0.5 * rhom * v_throat^2;
      P_throat  = Ps - Ks * 0.5 * rhos * v_suction^2; // throat is depressed below Ps

      // ═══════════════════════════════════════════════════════════════════════
      // 7. DIFFUSER  – pressure recovery (kinetic energy → static pressure)
      //    Kd is the diffuser loss fraction
      // ═══════════════════════════════════════════════════════════════════════
      dP_diffuser = (1 - Kd) * 0.5 * rhom *
                    (v_diffuser^2 - (m_discharge/(rhom*A_diff_out))^2);
      Pd = P_throat + dP_diffuser - dP_mixing;

      // ═══════════════════════════════════════════════════════════════════════
      // 8. ESDU PERFORMANCE CHARACTERISTIC (cross-check / alternative closure)
      //    N = (Pd - Ps) / (Pp - Pd)
      // ═══════════════════════════════════════════════════════════════════════
      N = (Pd - Ps) / max(Pp - Pd, 1e-3);

      // ═══════════════════════════════════════════════════════════════════════
      // 9. ENERGY BALANCE  – adiabatic mixing, no heat transfer
      // ═══════════════════════════════════════════════════════════════════════
      hd = (m_motive * hp + m_suction * hs) / m_discharge;
      state_d = Medium.setState_phX(Pd, hd, inStream(port_motive.Xi_outflow));

      // Reverse-flow enthalpy assignments (required by Modelica stream semantics)
      port_discharge.h_outflow = hd;
      port_motive.h_outflow    = inStream(port_discharge.h_outflow);
      port_suction.h_outflow   = inStream(port_discharge.h_outflow);

      // Species balance (single-component medium → trivial)
      port_motive.Xi_outflow   = inStream(port_discharge.Xi_outflow);
      port_suction.Xi_outflow  = inStream(port_discharge.Xi_outflow);
      port_discharge.Xi_outflow= inStream(port_motive.Xi_outflow);

          // Motive pipe (left)
          // Nozzle cone
          // Suction pipe (bottom)
          // Mixing chamber (throat)
          // Diffuser cone
          // Discharge pipe (right)
          // Labels
      annotation (
        Icon(graphics={
          Rectangle(extent={{-100,8},{-40,-8}},  fillColor={0,120,255},
                fillPattern =                                                       FillPattern.Solid),
          Polygon(points={{-40,8},{-20,4},{-20,-4},{-40,-8}},
                  fillColor={0,80,200}, fillPattern=FillPattern.Solid),
          Rectangle(extent={{-6,-10},{6,-94}},  fillColor={0,180,120},
                fillPattern =                                                      FillPattern.Solid),
          Rectangle(extent={{-20,12},{30,-12}}, fillColor={30,30,180},
                fillPattern =                                                      FillPattern.Solid),
          Polygon(points={{30,12},{90,20},{90,-20},{30,-12}},
                  fillColor={0,60,160}, fillPattern=FillPattern.Solid),
          Rectangle(extent={{90,20},{100,-20}}, fillColor={0,120,255},
                fillPattern =                                                      FillPattern.Solid),
          Text(extent={{-150,60},{150,40}},  textString="%name"),
          Text(extent={{-100,30},{-40,20}},  textString="Motive",  fontSize=8),
          Text(extent={{-20,-50},{20,-40}},  textString="Suction", fontSize=8),
          Text(extent={{60,35},{100,25}},    textString="Discharge",fontSize=8)}),
        Documentation(info="<html>
<h4>Jet Pump (Ejector) – Physical Model</h4>
<p>Models the four physical zones of a liquid-liquid jet pump:</p>
<ol>
  <li><b>Motive nozzle</b>: converts pressure → velocity via Bernoulli + Cd.</li>
  <li><b>Suction inlet</b>: secondary flow drawn by throat vacuum, with loss Ks.</li>
  <li><b>Mixing chamber</b>: momentum exchange between motive jet and suction stream, loss Km.</li>
  <li><b>Diffuser</b>: kinetic energy recovered as pressure, loss Kd.</li>
</ol>
<p>Performance is cross-checked against the ESDU 85032 (Cunningham) dimensionless
characteristic N = f(M, C, R, K*).</p>
<h4>Parameters to set for your application</h4>
<ul>
  <li><code>d_nozzle</code>, <code>d_throat</code>, <code>d_diffuser</code> – geometry from your datasheet.</li>
  <li><code>Cd_nozzle</code> – typically 0.93–0.97 for a sharp-edged nozzle.</li>
  <li>Loss coefficients Kp/Ks/Km/Kd – use 0.05/0.10/0.15/0.20 for a well-designed pump at Re > 2×10⁵.</li>
</ul>
<h4>Assumptions</h4>
<ul>
  <li>Adiabatic, steady-state, incompressible (density evaluated once per state).</li>
  <li>Single-component medium (extend Xi balance for mixtures).</li>
  <li>No cavitation guard – add <code>assert(P_throat &gt; Medium.saturationPressure(T), ...)</code> if needed.</li>
</ul>
</html>"));
    end JetPump_Claude;

    model NCFL
      extends BaseClasses.Partial_SubSystem(
        replaceable package Medium = Modelica.Media.Water.StandardWater,
        redeclare replaceable BaseClasses.CS_Dummy CS,
        redeclare replaceable BaseClasses.ED_Dummy ED,
        redeclare BaseClasses.Data_NCFL data(
          Init_T=291.15,
          Pump_Mflow=0.04,                   HX_L=0.62,
          HX_radius=0.02,
          Thermal_Cond=80),
        port_b(redeclare package Medium = Modelica.Media.Water.StandardWater),
        port_a(redeclare package Medium = Modelica.Media.Water.StandardWater));
      BaseClasses.Data_NCFL data(
        Init_T=291.15,           Heater_Length=1.5446375/3,
        Pump_Mflow=0.04,                                    HX_L=0.62,
        HX_radius=0.02,
        Thermal_Cond=80)
        annotation (Placement(transformation(extent={{78,102},{98,122}})));
      Modelica.Fluid.Pipes.StaticPipe Slant(
        redeclare package Medium = Medium,
        length=data.Slant_Pipe_L,
        diameter=data.Pipe_D,
        height_ab=data.Slant,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01)
        annotation (Placement(transformation(extent={{-10,72},{10,92}})));
      Modelica.Fluid.Pipes.StaticPipe Distance2Heaters(
        redeclare package Medium = Medium,
        length=0.6016625,
        diameter=data.Pipe_D,
        height_ab=0.6016625,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-82})));
      Modelica.Fluid.Pipes.StaticPipe PumpPipe(
        redeclare package Medium = Medium,
        length=1.252,
        diameter=data.Pipe_D,
        height_ab=0.3,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={70,-188})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
          Medium =
            Medium,
        use_input=true,
        m_flow_nominal=data.Pump_Mflow,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{46,-198},{26,-178}})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHX(
        redeclare package Medium = Medium,
        length=data.Height,
        diameter=data.Pipe_D,
        height_ab=-4,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-78})));


      TRANSFORM.Fluid.Volumes.MixingVolume volume(
        redeclare package Medium = Medium,
        p_start=data.Init_P,
        T_start=data.Init_T,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
        nPorts_a=1,
        nPorts_b=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={86,-116})));

      NHES.Fluid.Sensors.stateSensor TC1(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,-114})));
      NHES.Fluid.Sensors.stateDisplay TC1_
        annotation (Placement(transformation(extent={{-134,-130},{-80,-100}})));
      NHES.Fluid.Sensors.stateSensor TC2(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,68})));
      NHES.Fluid.Sensors.stateSensor TC3(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={62,46})));
      NHES.Fluid.Sensors.stateSensor TC6(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={86,-142})));
      NHES.Fluid.Sensors.stateDisplay TC2_
        annotation (Placement(transformation(extent={{-184,64},{-130,94}})));
      NHES.Fluid.Sensors.stateDisplay TC3_
        annotation (Placement(transformation(extent={{0,22},{54,52}})));
      NHES.Fluid.Sensors.stateDisplay TC6_
        annotation (Placement(transformation(extent={{2,-104},{56,-74}})));
      Modelica.Fluid.Pipes.StaticPipe V1_Inlet(
        redeclare package Medium = Medium,
        length=0.1905,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={38,-160})));
      Modelica.Fluid.Valves.ValveIncompressible V_top(
        redeclare package Medium = Medium,
        dp_nominal=1000,
        m_flow_nominal=data.Pump_Mflow)
        annotation (Placement(transformation(extent={{12,-170},{-8,-150}})));
      Modelica.Fluid.Valves.ValveIncompressible V_bot(
        redeclare package Medium = Medium,
        dp_nominal=1000,
        m_flow_nominal=data.Pump_Mflow)
        annotation (Placement(transformation(extent={{4,-198},{-16,-178}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=TC2_.T)
        annotation (Placement(transformation(extent={{-210,2},{-190,22}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=-TC1_.T)
        annotation (Placement(transformation(extent={{-210,-24},{-190,-4}})));
      Modelica.Blocks.Math.Add T_diff_HL
        annotation (Placement(transformation(extent={{-152,-8},{-132,12}})));
      Modelica.Fluid.Pipes.StaticPipe JetInlet(
        redeclare package Medium = Medium,
        length=0.254,
        diameter=data.JetPump_D,
        height_ab=0.254,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-63,-176})));
      Modelica.Fluid.Pipes.StaticPipe DistanceAfterHeaters(
        redeclare package Medium = Medium,
        length=2.92,
        diameter=data.Pipe_D,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,42})));
      Components.Heater heater3(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius)
                                       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,10})));
      Components.Heater heater2(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius)
                                       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,-18})));
      Components.Heater heater1(
        HeaterLength=data.Heater_Length,
        HeaterRadius=data.Heater_radius)
                                       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-62,-52})));
      Modelica.Fluid.Pipes.StaticPipe JetSuction(
        redeclare package Medium = Medium,
        length=0.36195,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-160})));
      Modelica.Fluid.Pipes.StaticPipe ValveOutlet(
        redeclare package Medium = Medium,
        length=0.4572,
        diameter=data.Pipe_D,
        redeclare model FlowModel =
            Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-34,-188})));
      Modelica.Fluid.Pipes.StaticPipe JetPump(
        redeclare package Medium = Medium,
        length=data.JetPump_L,
        diameter=data.JetPump_D,
        height_ab=data.JetPump_L,
        p_a_start=data.Init_P,
        m_flow_start=0.01) annotation (Placement(transformation(
            extent={{-10,-9},{10,9}},
            rotation=90,
            origin={-65,-144})));
      Components.HX_Isolated HX(
        HXLength=data.HX_L,
        HXRadius=data.HX_radius,
        HX_Transfer=-10.2E3,
        Therm_cond=data.Thermal_Cond)
                           annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={72,10})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=-TC3_.T)
        annotation (Placement(transformation(extent={{-212,-48},{-192,-28}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=TC6_.T)
        annotation (Placement(transformation(extent={{-212,-74},{-192,-54}})));
      Modelica.Blocks.Math.Add T_diff_CL
        annotation (Placement(transformation(extent={{-154,-58},{-134,-38}})));
      Modelica.Blocks.Sources.RealExpression FlowRate(y=pump.m_flow)
        annotation (Placement(transformation(extent={{-150,124},{-130,144}})));
      Modelica.Blocks.Math.Add T_diff
        annotation (Placement(transformation(extent={{-154,-98},{-134,-78}})));
      Modelica.Blocks.Sources.RealExpression realExpression4(y=TC2_.T)
        annotation (Placement(transformation(extent={{-226,-92},{-206,-72}})));
      Modelica.Blocks.Sources.RealExpression realExpression5(y=-TC6_.T)
        annotation (Placement(transformation(extent={{-228,-120},{-208,-100}})));
      NHES.Fluid.Sensors.stateSensor TC4(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={84,48})));
      NHES.Fluid.Sensors.stateSensor TC5(redeclare package Medium = Medium)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={78,-24})));
      NHES.Fluid.Sensors.stateDisplay TC4_
        annotation (Placement(transformation(extent={{116,80},{170,110}})));
      NHES.Fluid.Sensors.stateDisplay TC5_
        annotation (Placement(transformation(extent={{110,-28},{164,2}})));
    equation
      connect(DistanceAfterHX.port_b, volume.port_a[1])
        annotation (Line(points={{86,-88},{86,-110}},color={0,127,255}));
      connect(Distance2Heaters.port_a, TC1.port_b)
        annotation (Line(points={{-64,-92},{-64,-104}}, color={0,127,255}));
      connect(TC2.port_b, Slant.port_a) annotation (Line(points={{-64,78},{-64,
              80},{-52,80},{-52,82},{-10,82}}, color={0,127,255}));
      connect(Slant.port_b, TC3.port_a) annotation (Line(points={{10,82},{10,92},
              {62,92},{62,56}}, color={0,127,255}));
      connect(volume.port_b[1], TC6.port_a)
        annotation (Line(points={{86,-122},{86,-132}}, color={0,127,255}));
      connect(TC1.statePort, TC1_.statePort) annotation (Line(points={{-64.05,-113.95},
              {-48,-113.95},{-48,-144},{-50,-144},{-50,-160},{-107,-160},{-107,
              -118.9}}, color={0,0,0}));
      connect(TC2.statePort, TC2_.statePort) annotation (Line(points={{-64.05,
              68.05},{-64.05,70},{-126,70},{-126,58},{-157,58},{-157,75.1}},
            color={0,0,0}));
      connect(TC3.statePort, TC3_.statePort) annotation (Line(points={{61.95,
              45.95},{54,45.95},{54,14},{27,14},{27,33.1}}, color={0,0,0}));
      connect(TC6.statePort, TC6_.statePort) annotation (Line(points={{85.95,-142.05},
              {29,-142.05},{29,-92.9}}, color={0,0,0}));
      connect(V1_Inlet.port_a, TC6.port_b) annotation (Line(points={{48,-160},{
              86,-160},{86,-152}}, color={0,127,255}));
      connect(V1_Inlet.port_b, V_top.port_a)
        annotation (Line(points={{28,-160},{12,-160}}, color={0,127,255}));
      connect(realExpression.y, T_diff_HL.u1) annotation (Line(points={{-189,12},
              {-164,12},{-164,8},{-154,8}}, color={0,0,127}));
      connect(realExpression1.y, T_diff_HL.u2) annotation (Line(points={{-189,-14},
              {-162,-14},{-162,-4},{-154,-4}}, color={0,0,127}));
      connect(DistanceAfterHeaters.port_b, TC2.port_a)
        annotation (Line(points={{-64,52},{-64,58}}, color={0,127,255}));
      connect(heater3.port_b, DistanceAfterHeaters.port_a) annotation (Line(
            points={{-63.4,20},{-63.4,26},{-64,26},{-64,32}},
                                                          color={0,127,255}));
      connect(heater2.port_b, heater3.port_a)
        annotation (Line(points={{-63.4,-8},{-63.4,-4},{-63.2,-4},{-63.2,0}},
                                                     color={0,127,255}));
      connect(Distance2Heaters.port_b, heater1.port_a) annotation (Line(points={{-64,-72},
              {-64,-66},{-63.2,-66},{-63.2,-62}},      color={0,127,255}));
      connect(heater1.port_b, heater2.port_a)
        annotation (Line(points={{-63.4,-42},{-63.4,-36},{-63.2,-36},{-63.2,-28}},
                                                       color={0,127,255}));
      connect(V_top.port_b, JetSuction.port_a)
        annotation (Line(points={{-8,-160},{-24,-160}}, color={0,127,255}));
      connect(JetInlet.port_a, ValveOutlet.port_b) annotation (Line(points={{-63,-186},
              {-63,-188},{-44,-188}}, color={0,127,255}));
      connect(ValveOutlet.port_a, V_bot.port_b)
        annotation (Line(points={{-24,-188},{-16,-188}}, color={0,127,255}));
      connect(JetInlet.port_b, JetPump.port_a) annotation (Line(points={{-63,-166},{
              -63,-162},{-65,-162},{-65,-154}}, color={0,127,255}));
      connect(JetSuction.port_b, JetPump.port_a) annotation (Line(points={{-44,-160},
              {-65,-160},{-65,-154}}, color={0,127,255}));
      connect(JetPump.port_b, TC1.port_a) annotation (Line(points={{-65,-134},{
              -65,-129},{-64,-129},{-64,-124}}, color={0,127,255}));
      connect(pump.port_b, V_bot.port_a)
        annotation (Line(points={{26,-188},{4,-188}}, color={0,127,255}));
      connect(pump.port_a, PumpPipe.port_b)
        annotation (Line(points={{46,-188},{60,-188}}, color={0,127,255}));
      connect(PumpPipe.port_a, TC6.port_b) annotation (Line(points={{80,-188},{
              86,-188},{86,-152}}, color={0,127,255}));
      connect(realExpression2.y, T_diff_CL.u1) annotation (Line(points={{-191,-38},
              {-166,-38},{-166,-42},{-156,-42}}, color={0,0,127}));
      connect(realExpression3.y, T_diff_CL.u2) annotation (Line(points={{-191,-64},
              {-164,-64},{-164,-54},{-156,-54}}, color={0,0,127}));
      connect(actuatorBus.TopValve_Opening, V_top.opening) annotation (Line(
          points={{30,100},{30,58},{-6,58},{-6,-144},{2,-144},{2,-152}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, V_bot.opening) annotation (Line(
          points={{30,100},{30,58},{-6,58},{-6,-144},{18,-144},{18,-180},{-6,-180}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(TC3.port_b, HX.port_a_tube) annotation (Line(points={{62,36},{62,
              26},{68,26},{68,20}}, color={0,127,255}));
      connect(HX.port_b_tube, DistanceAfterHX.port_a) annotation (Line(points={{68,
              2.66454e-15},{68,-58},{86,-58},{86,-68}},   color={0,127,255}));
      connect(actuatorBus.Pump_Power, pump.in_m_flow) annotation (Line(
          points={{30,100},{30,-68},{62,-68},{62,-174},{36,-174},{36,-180.7}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.PumpMFlow, FlowRate.y) annotation (Line(
          points={{-30,100},{-30,134},{-129,134}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.TdiffHL, T_diff_HL.y) annotation (Line(
          points={{-30,100},{-124,100},{-124,2},{-131,2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.TdiffCL, T_diff_CL.y) annotation (Line(
          points={{-30,100},{-124,100},{-124,-48},{-133,-48}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(T_diff.u1, realExpression4.y) annotation (Line(points={{-156,-82},
              {-205,-82}},                       color={0,0,127}));
      connect(T_diff.u2, realExpression5.y) annotation (Line(points={{-156,-94},
              {-200,-94},{-200,-110},{-207,-110}},  color={0,0,127}));
      connect(sensorBus.Tdiff, T_diff.y) annotation (Line(
          points={{-30,100},{-86,100},{-86,-88},{-133,-88}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.Heater1_Power, heater1.HeaterPower) annotation (Line(
          points={{30,100},{-82,100},{-82,-52},{-72.4,-52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater2_Power, heater2.HeaterPower) annotation (Line(
          points={{30,100},{-82,100},{-82,-18},{-72.4,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater3_Power, heater3.HeaterPower) annotation (Line(
          points={{30,100},{-82,100},{-82,10},{-72.4,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(TC4.statePort, TC4_.statePort) annotation (Line(points={{83.95,
              48.05},{83.95,63.975},{143,63.975},{143,91.1}}, color={0,0,0}));
      connect(TC5.statePort, TC5_.statePort) annotation (Line(points={{77.95,
              -23.95},{107.975,-23.95},{107.975,-16.9},{137,-16.9}}, color={0,0,
              0}));
      connect(port_a, TC5.port_a) annotation (Line(points={{104,-6},{92,-6},{92,
              -24},{94,-24},{94,-40},{78,-40},{78,-34}}, color={0,127,255}));
      connect(TC5.port_b, HX.port_a_shell) annotation (Line(points={{78,-14},{
              78,-4},{73.8,-4},{73.8,1.77636e-15}}, color={0,127,255}));
      connect(HX.port_b_shell, TC4.port_a) annotation (Line(points={{73.8,20},{
              72,20},{72,30},{84,30},{84,38}}, color={0,127,255}));
      connect(port_b, TC4.port_b) annotation (Line(points={{104,60},{104,58},{
              84,58}}, color={0,127,255}));
      annotation (experiment(StartTime=0, StopTime=180, Interval=0.1), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
                -200},{100,160}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-220,-200},{100,160}})));
    end NCFL;
  end Components;

  package ControlSystems
    model RegularCS
      extends BaseClasses.CS_Dummy;

    end RegularCS;

    model SF_AVO_CS
      extends RegularCS;
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-64,26},{-44,46}})));
      Modelica.Blocks.Sources.Constant const1(k=20)
        annotation (Placement(transformation(extent={{-70,68},{-50,88}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{-66,-26},{-46,-6}})));
    equation
      connect(actuatorBus.TopValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,36},{-43,36}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,36},{-43,36}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Pump_Power, const1.y) annotation (Line(
          points={{30,-100},{30,78},{-49,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater1_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-16},{-45,-16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater2_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-16},{-45,-16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater3_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-16},{-45,-16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end SF_AVO_CS;

    model TVC_CS
      extends RegularCS;
      Modelica.Blocks.Sources.Constant const1(k=1)
        annotation (Placement(transformation(extent={{-52,18},{-32,38}})));
      Modelica.Blocks.Sources.Constant const2(k=20)
        annotation (Placement(transformation(extent={{-54,-16},{-34,4}})));
      Modelica.Blocks.Sources.Pulse pulse(
        width=10,
        period=190,
        offset=0,
        startTime=0)
        annotation (Placement(transformation(extent={{-50,62},{-30,82}})));
      Modelica.Blocks.Sources.Constant const3(k=2.5E3)
        annotation (Placement(transformation(extent={{-54,-48},{-34,-28}})));
    equation
      connect(actuatorBus.BotValve_Opening, const1.y) annotation (Line(
          points={{30,-100},{30,28},{-31,28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Pump_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-6},{-33,-6}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.TopValve_Opening, pulse.y) annotation (Line(
          points={{30,-100},{30,72},{-29,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater_Power, const3.y) annotation (Line(
          points={{30,-100},{30,-38},{-33,-38}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end TVC_CS;

    model NF_BV_CS
      extends RegularCS;
      Modelica.Blocks.Sources.Pulse pulse(
        amplitude=20,
        width=10,
        period=190,
        offset=0,
        startTime=0)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      Modelica.Blocks.Sources.Pulse pulse1(
        width=10,
        period=190,
        offset=0,
        startTime=0)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-90,36},{-70,56}})));
      Modelica.Blocks.Sources.Constant const3(k=1)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Modelica.Blocks.Sources.Constant const2(k=5.5E3)
        annotation (Placement(transformation(extent={{-42,-58},{-22,-38}})));
    equation
      connect(actuatorBus.Pump_Power, pulse.y) annotation (Line(
          points={{30,-100},{30,-10},{-19,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, pulse1.y) annotation (Line(
          points={{30,-100},{30,30},{-19,30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.TopValve_Opening, const3.y) annotation (Line(
          points={{30,-100},{30,70},{-19,70}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-48},{-21,-48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end NF_BV_CS;

    model Dynamic_CS
      extends BaseClasses.CS_Dummy;

      Modelica.Blocks.Sources.CombiTimeTable PumpPower(
        tableOnFile=false,
        table=[0,0.57641872806864; 0.57,0.57486050254416; 1.061,
            0.57667843232272; 1.56,0.57408138978192; 2.063,0.58005458762576;
            2.562,0.57797695359312; 3.062,0.5756396153064; 3.562,
            0.5782366578472; 4.062,0.57537991105232; 4.562,0.57641872806864;
            5.059,0.57356198127376; 5.562,0.57018582597072; 6.062,
            0.56940671320848; 6.563,0.56499174088912; 7.061,0.567848487684;
            7.563,0.5665499664136; 8.061,0.56836789619216; 8.561,0.567848487684;
            9.061,0.56966641746256; 9.562,0.56758878342992; 10.061,
            0.56992612171664; 10.562,0.56836789619216; 11.061,0.5730425727656;
            11.563,0.57252316425744; 12.06,0.57537991105232; 12.561,
            0.57382168552784; 13.061,0.56888730470032; 13.562,0.57070523447888;
            14.059,0.57148434724112; 14.561,0.5730425727656; 15.061,
            0.56966641746256; 15.562,0.56992612171664; 16.06,0.57226346000336;
            16.559,0.57382168552784; 17.062,0.57278286851152; 17.562,
            0.57589931956048; 18.062,0.57330227701968; 18.56,0.574341094036;
            19.063,0.57537991105232; 19.562,0.57408138978192; 20.062,
            0.57875606635536; 20.561,0.57901577060944; 21.062,0.57979488337168;
            21.561,0.57719784083088; 22.061,0.57096493873296; 22.562,
            0.57096493873296; 23.061,0.57252316425744; 23.561,0.57226346000336;
            24.062,0.56940671320848; 24.561,0.5704455302248; 25.063,
            0.56862760044624; 25.561,0.5730425727656; 26.062,0.57512020679824;
            26.561,0.57589931956048; 27.062,0.57927547486352; 27.562,
            0.57667843232272; 28.061,0.580833700388; 28.562,0.57615902381456;
            29.062,0.574341094036; 29.563,0.5795351791176; 30.062,
            0.5782366578472; 30.562,0.57771724933904; 31.062,0.5756396153064;
            31.563,0.5795351791176; 32.061,0.580833700388; 32.559,
            0.57901577060944; 33.063,0.57667843232272; 33.56,0.5756396153064;
            34.06,0.57226346000336; 34.561,0.57382168552784; 35.061,
            0.57512020679824; 35.56,0.57589931956048; 36.062,0.57667843232272;
            36.562,0.57460079829008; 37.061,0.57330227701968; 37.562,
            0.574341094036; 38.061,0.57226346000336; 38.56,0.57382168552784;
            39.06,0.57382168552784; 39.563,0.56940671320848; 40.061,
            0.57226346000336; 40.562,0.57641872806864; 41.061,0.57330227701968;
            41.561,0.5704455302248; 42.063,0.57122464298704; 42.56,
            0.567848487684; 43.061,0.57122464298704; 43.558,0.57252316425744;
            44.061,0.57667843232272; 44.562,0.56732907917584; 45.062,
            0.5691470089544; 45.56,0.56940671320848; 46.064,0.56888730470032;
            46.562,0.57096493873296; 47.06,0.57278286851152; 47.56,
            0.57252316425744; 48.061,0.57589931956048; 48.561,0.57979488337168;
            49.061,0.58005458762576; 49.561,0.57875606635536; 50.061,
            0.57667843232272; 50.561,0.57641872806864; 51.062,0.5769381365768;
            51.56,0.57719784083088; 52.061,0.57537991105232; 52.561,
            0.57537991105232; 53.062,0.57537991105232; 53.562,0.57252316425744;
            54.058,0.57512020679824; 54.56,0.57382168552784; 55.06,
            0.57745754508496; 55.561,0.5756396153064; 56.062,0.57615902381456;
            56.562,0.57537991105232; 57.061,0.5795351791176; 57.561,
            0.58265163016656; 58.061,0.580833700388; 58.559,0.5821322216584;
            59.058,0.58420985569104; 59.558,0.5847292641992; 60.058,
            0.58135310889616; 60.559,0.57589931956048; 61.06,0.57512020679824;
            61.56,0.57330227701968; 62.061,0.57278286851152; 62.56,
            0.567848487684; 63.058,0.56888730470032; 63.56,0.56810819193808;
            64.059,0.5691470089544; 64.559,0.56992612171664; 65.063,
            0.57122464298704; 65.561,0.57070523447888; 66.062,0.57278286851152;
            66.561,0.5704455302248; 67.061,0.57122464298704; 67.562,
            0.57382168552784; 68.062,0.5730425727656; 68.561,0.57486050254416;
            69.062,0.57615902381456; 69.562,0.57745754508496; 70.061,
            0.57667843232272; 70.561,0.57771724933904; 71.061,0.57382168552784;
            71.561,0.57615902381456; 72.061,0.57460079829008; 72.558,
            0.57537991105232; 73.062,0.57719784083088; 73.562,0.57875606635536;
            74.062,0.58031429187984; 74.561,0.58057399613392; 75.062,
            0.57537991105232; 75.561,0.57849636210128; 76.061,0.57537991105232;
            76.562,0.57771724933904; 77.062,0.57641872806864; 77.562,
            0.57667843232272; 78.062,0.57615902381456; 78.563,0.5769381365768;
            79.061,0.57719784083088; 79.56,0.57537991105232; 80.061,
            0.57589931956048; 80.561,0.56966641746256; 81.062,0.56992612171664;
            81.561,0.57070523447888; 82.061,0.57901577060944; 82.561,
            0.57927547486352; 83.061,0.57875606635536; 83.562,0.57901577060944;
            84.06,0.58135310889616; 84.56,0.57797695359312; 85.063,
            0.57797695359312; 85.562,0.57719784083088; 86.062,0.57849636210128;
            86.561,0.58005458762576; 87.062,0.58187251740432; 87.561,
            0.58446955994512; 88.062,0.58239192591248; 88.561,0.58135310889616;
            89.061,0.580833700388; 89.562,0.58369044718288; 90.062,
            0.58265163016656; 90.562,0.5821322216584; 91.061,0.57901577060944;
            91.561,0.58057399613392; 92.061,0.5795351791176; 92.561,
            0.57927547486352; 93.061,0.57901577060944; 93.56,0.57901577060944;
            94.061,0.5756396153064; 94.561,0.57537991105232; 95.061,
            0.57771724933904; 95.561,0.57486050254416; 96.071,0.56940671320848;
            96.561,0.56966641746256; 97.063,0.57330227701968; 97.562,
            0.57641872806864; 98.062,0.57615902381456; 98.561,0.57278286851152;
            99.062,0.57460079829008; 99.562,0.57252316425744; 100.063,
            0.5769381365768; 100.563,0.57252316425744; 101.061,0.57330227701968;
            101.562,0.57408138978192; 102.062,0.57537991105232; 102.561,
            0.57278286851152; 103.061,0.57148434724112; 103.563,
            0.57486050254416; 104.063,0.57148434724112; 104.562,
            0.57252316425744; 105.091,0.57512020679824; 105.559,
            0.57589931956048; 106.061,0.57408138978192; 106.56,0.5717440514952;
            107.061,0.5717440514952; 107.56,0.56732907917584; 108.062,
            0.57148434724112; 108.561,0.57070523447888; 109.061,
            0.57122464298704; 109.561,0.57408138978192; 110.062,
            0.57252316425744; 110.561,0.5717440514952; 111.061,0.574341094036;
            111.561,0.5756396153064; 112.06,0.57330227701968; 112.562,
            0.57460079829008; 113.059,0.57641872806864; 113.562,0.5717440514952;
            114.062,0.57278286851152; 114.561,0.57460079829008; 115.063,
            0.57901577060944; 115.562,0.57875606635536; 116.063,
            0.57849636210128; 116.561,0.58161281315024; 117.063,
            0.57875606635536; 117.562,0.5795351791176; 118.061,0.57979488337168;
            118.561,0.57927547486352; 119.062,0.5795351791176; 119.563,
            0.5782366578472; 120.062,0.57589931956048; 120.563,0.57486050254416;
            121.061,0.57719784083088; 121.562,0.58109340464208; 122.061,
            0.57927547486352; 122.562,0.5782366578472; 123.063,0.5795351791176;
            123.562,0.57771724933904; 124.063,0.5769381365768; 124.563,
            0.57641872806864; 125.062,0.5769381365768; 125.561,0.57771724933904;
            126.062,0.57667843232272; 126.56,0.5795351791176; 127.061,
            0.57979488337168; 127.564,0.57901577060944; 128.063,
            0.57589931956048; 128.563,0.57070523447888; 129.075,
            0.57200375574928; 129.562,0.56966641746256; 130.061,
            0.56732907917584; 130.56,0.57148434724112; 131.063,0.57486050254416;
            131.561,0.57641872806864; 132.06,0.57460079829008; 132.561,
            0.57797695359312; 133.06,0.57719784083088; 133.56,0.5769381365768;
            134.062,0.57797695359312; 134.561,0.5782366578472; 135.06,
            0.57771724933904; 135.562,0.57667843232272; 136.062,
            0.57771724933904; 136.559,0.57927547486352; 137.059,
            0.57745754508496; 137.559,0.58057399613392; 138.07,0.5782366578472;
            138.56,0.5756396153064; 139.062,0.57615902381456; 139.558,
            0.57486050254416; 140.061,0.5730425727656; 140.561,0.57512020679824;
            141.06,0.57460079829008; 141.562,0.574341094036; 142.062,
            0.5730425727656; 142.562,0.57226346000336; 143.061,0.57148434724112;
            143.562,0.56706937492176; 144.062,0.56966641746256; 144.562,
            0.57018582597072; 145.06,0.57226346000336; 145.562,0.57356198127376;
            146.062,0.5730425727656; 146.558,0.57408138978192; 147.064,
            0.57200375574928; 147.562,0.5730425727656; 148.06,0.5730425727656;
            148.562,0.57148434724112; 149.062,0.5756396153064; 149.562,
            0.57252316425744; 150.062,0.57589931956048; 150.562,
            0.57356198127376; 151.06,0.57070523447888; 151.563,0.56810819193808;
            152.062,0.56966641746256; 152.561,0.56888730470032; 153.064,
            0.5704455302248; 153.562,0.5717440514952; 154.062,0.57122464298704;
            154.562,0.57589931956048; 155.059,0.57719784083088; 155.562,
            0.57979488337168; 156.061,0.58446955994512; 156.56,0.5834307429288;
            157.063,0.58706660248592; 157.563,0.5834307429288; 158.061,
            0.58291133442064; 158.563,0.58369044718288; 159.061,0.5821322216584;
            159.56,0.580833700388; 160.062,0.57979488337168; 160.562,
            0.58005458762576; 161.062,0.57589931956048; 161.558,
            0.57849636210128; 162.062,0.574341094036; 162.567,0.57512020679824;
            163.061,0.57927547486352; 163.561,0.57641872806864; 164.061,
            0.57589931956048; 164.559,0.57745754508496; 165.06,0.57408138978192;
            165.558,0.5769381365768; 166.059,0.57667843232272; 166.559,
            0.57901577060944; 167.059,0.5717440514952; 167.559,0.57667843232272;
            168.062,0.57537991105232; 168.558,0.57486050254416; 169.06,
            0.57537991105232; 169.562,0.5769381365768; 170.062,0.57667843232272;
            170.561,0.5769381365768; 171.065,0.57719784083088; 171.559,
            0.57745754508496; 172.062,0.57901577060944; 172.56,0.57927547486352;
            173.059,0.58031429187984; 173.56,0.58005458762576; 174.06,
            0.57927547486352; 174.56,0.57745754508496; 175.059,0.57979488337168;
            175.559,0.57849636210128; 176.062,0.57745754508496; 176.56,
            0.57460079829008; 177.061,0.57615902381456; 177.561,
            0.57408138978192; 178.06,0.5717440514952; 178.558,0.5730425727656;
            179.06,0.57641872806864; 179.559,0.57408138978192; 180.06,
            0.5730425727656; 180.561,0.5730425727656; 181.061,0.5730425727656;
            181.559,0.57460079829008; 182.061,0.57486050254416; 182.56,
            0.57512020679824; 183.062,0.57667843232272; 183.562,0.5769381365768;
            184.06,0.574341094036; 184.563,0.57615902381456; 185.061,
            0.5769381365768; 185.562,0.57615902381456; 186.059,0.57486050254416;
            186.559,0.57771724933904; 187.062,0.57615902381456; 187.562,
            0.57745754508496; 188.061,0.58031429187984; 188.559,
            0.57901577060944; 189.061,0.58317103867472; 189.561,
            0.57979488337168; 190.062,0.57979488337168; 190.561,0.5782366578472;
            191.062,0.57979488337168; 191.558,0.58005458762576; 192.06,
            0.57356198127376; 192.559,0.57200375574928; 193.062,
            0.57641872806864; 193.561,0.57226346000336; 194.062,
            0.56732907917584; 194.562,0.57148434724112; 195.062,
            0.57096493873296; 195.562,0.5717440514952; 196.058,0.57226346000336;
            196.558,0.574341094036; 197.061,0.57382168552784; 197.561,
            0.57252316425744; 198.062,0.5756396153064; 198.563,0.57148434724112;
            199.061,0.574341094036; 199.561,0.57382168552784; 200.062,
            0.57252316425744; 200.559,0.57719784083088; 201.062,
            0.57356198127376; 201.559,0.5782366578472; 202.062,0.5769381365768;
            202.561,0.57797695359312; 203.062,0.5769381365768; 203.563,
            0.5769381365768; 204.061,0.57512020679824; 204.563,0.58005458762576;
            205.062,0.57615902381456; 205.562,0.57719784083088; 206.061,
            0.57641872806864; 206.56,0.57512020679824; 207.06,0.5769381365768;
            207.562,0.57667843232272; 208.062,0.57408138978192; 208.559,
            0.57382168552784; 209.062,0.57278286851152; 209.562,
            0.57252316425744; 210.061,0.57356198127376; 210.562,
            0.57486050254416; 211.063,0.5769381365768; 211.562,0.574341094036;
            212.062,0.57979488337168; 212.562,0.5756396153064; 213.062,
            0.57745754508496; 213.561,0.5769381365768; 214.061,0.57719784083088;
            214.559,0.58005458762576; 215.062,0.58109340464208; 215.562,
            0.58057399613392; 216.061,0.58031429187984; 216.563,
            0.58420985569104; 217.059,0.58395015143696; 217.562,
            0.58395015143696; 218.062,0.58291133442064; 218.563,
            0.57901577060944; 219.063,0.5782366578472; 219.56,0.58031429187984;
            220.062,0.58109340464208; 220.562,0.580833700388; 221.061,
            0.5821322216584; 221.563,0.58239192591248; 222.061,0.58135310889616;
            222.562,0.58109340464208; 223.061,0.57979488337168; 223.562,
            0.58057399613392; 224.061,0.58161281315024; 224.56,0.58161281315024;
            225.063,0.58161281315024; 225.562,0.57797695359312; 226.062,
            0.5769381365768; 226.56,0.5756396153064; 227.061,0.57849636210128;
            227.561,0.5782366578472; 228.062,0.58265163016656; 228.561,
            0.5834307429288; 229.059,0.58187251740432; 229.561,0.5834307429288;
            230.062,0.5834307429288; 230.561,0.5834307429288; 231.062,
            0.58135310889616; 231.56,0.58031429187984; 232.062,0.57927547486352;
            232.563,0.5782366578472; 233.06,0.57927547486352; 233.562,
            0.5795351791176; 234.06,0.58005458762576; 234.56,0.57927547486352;
            235.06,0.5795351791176; 235.561,0.57901577060944; 236.062,
            0.57849636210128; 236.561,0.5795351791176; 237.062,0.57771724933904;
            237.561,0.57797695359312; 238.061,0.57979488337168; 238.562,
            0.57719784083088; 239.062,0.5782366578472; 239.559,0.57589931956048;
            240.061,0.57797695359312; 240.559,0.57901577060944; 241.061,
            0.5795351791176; 241.559,0.57901577060944; 242.061,0.58031429187984;
            242.558,0.58239192591248; 243.062,0.58135310889616; 243.562,
            0.58187251740432; 244.061,0.580833700388; 244.561,0.58109340464208;
            245.061,0.5834307429288; 245.559,0.58265163016656; 246.061,
            0.58395015143696; 246.56,0.58628748972368; 247.062,0.58369044718288;
            247.561,0.5847292641992; 248.059,0.58265163016656; 248.561,
            0.58420985569104; 249.06,0.58291133442064; 249.562,0.58005458762576;
            250.063,0.58265163016656; 250.561,0.57979488337168; 251.06,
            0.58005458762576; 251.561,0.58135310889616; 252.06,0.57875606635536;
            252.562,0.5782366578472; 253.06,0.57849636210128; 253.561,
            0.57615902381456; 254.062,0.57719784083088; 254.562,
            0.57615902381456; 255.058,0.57849636210128; 255.562,
            0.58109340464208; 256.063,0.57849636210128; 256.562,
            0.58265163016656; 257.061,0.58291133442064; 257.563,
            0.58239192591248; 258.059,0.58239192591248; 258.567,
            0.58161281315024; 259.062,0.58265163016656; 259.562,
            0.58239192591248; 260.063,0.58420985569104; 260.558,
            0.58265163016656; 261.058,0.58524867270736; 261.559,0.5834307429288;
            262.059,0.58317103867472; 262.56,0.58369044718288; 263.059,
            0.5847292641992; 263.559,0.58654719397776; 264.062,0.58291133442064;
            264.559,0.58187251740432; 265.059,0.58239192591248; 265.562,
            0.5834307429288; 266.062,0.57719784083088; 266.562,0.58031429187984;
            267.06,0.57641872806864; 267.563,0.57979488337168; 268.062,
            0.57460079829008; 268.561,0.57745754508496; 269.061,
            0.57771724933904; 269.561,0.57771724933904; 270.062,
            0.57719784083088; 270.561,0.5782366578472; 271.062,0.57667843232272;
            271.562,0.57537991105232; 272.062,0.5756396153064; 272.562,
            0.5769381365768; 273.062,0.57486050254416; 273.562,0.57927547486352;
            274.063,0.57797695359312; 274.562,0.57745754508496; 275.062,
            0.57667843232272; 275.563,0.57408138978192; 276.064,
            0.57797695359312; 276.559,0.57745754508496; 277.062,
            0.58031429187984; 277.561,0.58005458762576; 278.061,
            0.57927547486352; 278.563,0.5795351791176; 279.062,0.57875606635536;
            279.561,0.5782366578472; 280.062,0.57875606635536; 280.562,
            0.57875606635536; 281.061,0.57797695359312; 281.559,
            0.57849636210128; 282.062,0.57927547486352; 282.561,
            0.57771724933904; 283.062,0.57849636210128; 283.563,
            0.57979488337168; 284.059,0.57745754508496; 284.562,
            0.57901577060944; 285.061,0.580833700388; 285.561,0.58317103867472;
            286.062,0.5821322216584; 286.56,0.58420985569104; 287.061,
            0.58550837696144; 287.559,0.58187251740432; 288.062,
            0.58161281315024; 288.562,0.5795351791176; 289.062,0.58395015143696;
            289.564,0.58446955994512; 290.062,0.5821322216584; 290.563,
            0.58005458762576; 291.059,0.5756396153064; 291.559,0.5756396153064;
            292.062,0.57901577060944; 292.563,0.5847292641992; 293.062,
            0.58550837696144; 293.563,0.57797695359312; 294.062,
            0.57875606635536; 294.559,0.5756396153064; 295.063,0.57615902381456;
            295.561,0.57589931956048; 296.061,0.57797695359312; 296.561,
            0.580833700388; 297.061,0.57797695359312; 297.563,0.58135310889616;
            298.061,0.58057399613392; 298.561,0.58187251740432; 299.061,
            0.58057399613392; 299.559,0.5821322216584; 300.063,0.57979488337168;
            300.561,0.58057399613392; 301.061,0.58057399613392; 301.564,
            0.5821322216584; 302.061,0.58031429187984; 302.562,0.58109340464208;
            303.063,0.58369044718288; 303.562,0.58109340464208; 304.062,
            0.58239192591248; 304.562,0.5821322216584; 305.062,0.58161281315024;
            305.561,0.58291133442064; 306.063,0.57901577060944; 306.563,
            0.58265163016656; 307.064,0.58187251740432; 307.561,
            0.58057399613392; 308.061,0.5834307429288; 308.564,0.58187251740432;
            309.063,0.58291133442064; 309.563,0.5834307429288; 310.061,
            0.58420985569104; 310.561,0.58239192591248; 311.062,0.5821322216584;
            311.562,0.58265163016656; 312.062,0.5821322216584; 312.561,
            0.58239192591248; 313.06,0.58161281315024; 313.562,0.58187251740432;
            314.062,0.58057399613392; 314.562,0.58187251740432; 315.062,
            0.580833700388; 315.561,0.57927547486352; 316.062,0.5847292641992;
            316.562,0.58265163016656; 317.062,0.58395015143696; 317.56,
            0.58369044718288; 318.063,0.58239192591248; 318.561,
            0.58369044718288; 319.064,0.58031429187984; 319.561,
            0.58109340464208; 320.063,0.58317103867472; 320.561,
            0.58187251740432; 321.062,0.5834307429288; 321.563,0.58109340464208;
            322.062,0.58005458762576; 322.56,0.5821322216584; 323.062,
            0.58109340464208; 323.563,0.5821322216584; 324.064,0.58420985569104;
            324.562,0.58317103867472; 325.063,0.58706660248592; 325.561,
            0.58446955994512; 326.064,0.58446955994512; 326.563,
            0.58187251740432; 327.062,0.58317103867472; 327.563,
            0.58498896845328; 328.063,0.58654719397776; 328.561,0.5860277854696;
            329.061,0.58628748972368; 329.561,0.58420985569104; 330.061,
            0.58187251740432; 330.563,0.5821322216584; 331.061,0.57927547486352;
            331.563,0.58057399613392; 332.064,0.58524867270736; 332.562,
            0.58524867270736; 333.062,0.58395015143696; 333.561,
            0.58706660248592; 334.062,0.58446955994512; 334.561,
            0.58758601099408; 335.062,0.58628748972368; 335.562,
            0.58836512375632; 336.063,0.58680689823184; 336.562,
            0.58888453226448; 337.062,0.5925203918216; 337.562,0.593818913092;
            338.062,0.59278009607568; 338.561,0.593818913092; 339.062,
            0.59018305353488; 339.563,0.58836512375632; 340.063,
            0.58654719397776; 340.563,0.58576808121552; 341.063,
            0.58395015143696; 341.558,0.58265163016656; 342.06,0.58291133442064;
            342.561,0.58239192591248; 343.061,0.58369044718288; 343.563,
            0.5834307429288; 344.06,0.58239192591248; 344.564,0.58109340464208;
            345.063,0.58576808121552; 345.563,0.5847292641992; 346.059,
            0.58784571524816; 346.562,0.5860277854696; 347.062,0.5886248280104;
            347.562,0.58836512375632; 348.062,0.58758601099408; 348.563,
            0.58836512375632; 349.062,0.59044275778896; 349.563,
            0.58966364502672; 350.063,0.59148157480528; 350.562,
            0.59070246204304; 351.062,0.58732630674; 351.561,0.58706660248592;
            352.062,0.58550837696144; 352.561,0.58291133442064; 353.061,
            0.58265163016656; 353.562,0.58420985569104; 354.062,
            0.58654719397776; 354.562,0.58810541950224; 355.062,
            0.58706660248592; 355.563,0.5886248280104; 356.062,0.58810541950224;
            356.56,0.58966364502672; 357.062,0.59096216629712; 357.561,
            0.59303980032976; 358.062,0.5912218705512; 358.561,0.5860277854696;
            359.064,0.58524867270736; 359.561,0.59070246204304; 360.062,
            0.58680689823184; 360.562,0.58628748972368; 361.059,
            0.58446955994512; 361.564,0.5834307429288; 362.063,0.58810541950224;
            362.558,0.58576808121552; 363.061,0.5821322216584; 363.563,
            0.58628748972368; 364.062,0.58135310889616; 364.561,
            0.58395015143696; 365.061,0.5847292641992; 365.56,0.58498896845328;
            366.063,0.58576808121552; 366.56,0.58420985569104; 367.062,
            0.58369044718288; 367.562,0.58498896845328; 368.062,
            0.58680689823184; 368.562,0.58498896845328; 369.063,
            0.58628748972368; 369.558,0.58784571524816; 370.061,0.58732630674;
            370.563,0.58888453226448; 371.063,0.58706660248592; 371.561,
            0.58706660248592; 372.064,0.59096216629712; 372.561,0.5899233492808;
            373.062,0.5886248280104; 373.563,0.58576808121552; 374.061,
            0.58420985569104; 374.561,0.58758601099408; 375.061,
            0.58680689823184; 375.562,0.58758601099408; 376.063,
            0.58654719397776; 376.562,0.59018305353488; 377.061,
            0.58680689823184; 377.561,0.58914423651856; 378.061,
            0.58758601099408; 378.561,0.59070246204304; 379.062,
            0.58888453226448; 379.562,0.59044275778896; 380.062,
            0.59096216629712; 380.561,0.59148157480528; 381.063,
            0.58628748972368; 381.563,0.58758601099408; 382.062,0.58732630674;
            382.564,0.58810541950224; 383.062,0.5860277854696; 383.561,
            0.58706660248592; 384.062,0.58810541950224; 384.562,
            0.59018305353488; 385.062,0.58784571524816; 385.564,
            0.59278009607568; 386.062,0.59018305353488; 386.562,
            0.59329950458384; 387.062,0.59563684287056; 387.562,
            0.59329950458384; 388.063,0.59485773010832; 388.563,
            0.59226068756752; 389.063,0.58966364502672; 389.562,
            0.58888453226448; 390.063,0.58914423651856; 390.562,0.5860277854696;
            391.064,0.58836512375632; 391.562,0.58758601099408; 392.063,
            0.58135310889616; 392.561,0.58057399613392; 393.063,
            0.58420985569104; 393.563,0.580833700388; 394.064,0.58317103867472;
            394.563,0.58187251740432; 395.062,0.580833700388; 395.563,
            0.58031429187984; 396.064,0.5821322216584; 396.563,0.58057399613392;
            397.062,0.5847292641992; 397.562,0.58654719397776; 398.062,
            0.5860277854696; 398.564,0.58810541950224; 399.061,0.58680689823184;
            399.562,0.58706660248592; 400.063,0.58498896845328; 400.563,
            0.58550837696144; 401.062,0.58524867270736; 401.559,
            0.58680689823184; 402.063,0.58784571524816; 402.561,
            0.58836512375632; 403.062,0.58836512375632; 403.56,0.58291133442064;
            404.061,0.58524867270736; 404.562,0.58498896845328; 405.062,
            0.58161281315024; 405.563,0.58524867270736; 406.059,
            0.58420985569104; 406.562,0.58758601099408; 407.062,
            0.58524867270736; 407.559,0.58576808121552; 408.062,
            0.58784571524816; 408.562,0.5860277854696; 409.062,0.58836512375632;
            409.562,0.58836512375632; 410.062,0.59174127905936; 410.562,
            0.59096216629712; 411.062,0.59200098331344; 411.563,
            0.58940394077264; 412.063,0.59200098331344; 412.563,0.5912218705512;
            413.062,0.59044275778896; 413.562,0.59226068756752; 414.062,
            0.59433832160016; 414.562,0.59070246204304; 415.061,
            0.59174127905936; 415.562,0.59018305353488; 416.062,
            0.59148157480528; 416.562,0.58966364502672; 417.06,0.5925203918216;
            417.561,0.58888453226448; 418.058,0.58836512375632; 418.561,
            0.58836512375632; 419.063,0.5847292641992; 419.563,0.58784571524816;
            420.062,0.58888453226448; 420.563,0.58758601099408; 421.064,
            0.58888453226448; 421.563,0.59303980032976; 422.06,0.593818913092;
            422.562,0.59044275778896; 423.059,0.59174127905936; 423.562,
            0.59355920883792; 424.064,0.5925203918216; 424.562,0.59096216629712;
            425.062,0.58680689823184; 425.563,0.58758601099408; 426.062,
            0.58732630674; 426.562,0.59044275778896; 427.06,0.59329950458384;
            427.564,0.59096216629712; 428.061,0.58654719397776; 428.561,
            0.58888453226448; 429.063,0.58914423651856; 429.561,
            0.59096216629712; 430.062,0.59200098331344; 430.561,0.5899233492808;
            431.062,0.59044275778896; 431.562,0.59070246204304; 432.058,
            0.58966364502672; 432.564,0.58914423651856; 433.064,0.5886248280104;
            433.563,0.59018305353488; 434.062,0.58940394077264; 434.563,
            0.59148157480528; 435.062,0.5899233492808; 435.563,0.5886248280104;
            436.061,0.5912218705512; 436.562,0.58680689823184; 437.059,
            0.59044275778896; 437.56,0.58888453226448; 438.193,0.59044275778896;
            438.559,0.58966364502672; 439.062,0.59174127905936; 439.563,
            0.5925203918216; 440.074,0.59044275778896; 440.561,0.59226068756752;
            441.06,0.59174127905936; 441.563,0.59070246204304; 442.061,
            0.58914423651856; 442.562,0.59096216629712; 443.064,
            0.59148157480528; 443.561,0.59174127905936; 444.064,
            0.59174127905936; 444.563,0.59226068756752; 445.075,
            0.58810541950224; 445.573,0.5886248280104; 446.063,0.58680689823184;
            446.582,0.5912218705512; 447.061,0.59174127905936; 447.564,
            0.59563684287056; 448.064,0.59433832160016; 448.562,
            0.59303980032976; 449.062,0.5899233492808; 449.559,0.59018305353488;
            450.059,0.59018305353488; 450.563,0.58810541950224; 451.062,
            0.58966364502672; 451.563,0.58498896845328; 452.059,
            0.59044275778896; 452.564,0.58784571524816; 453.06,0.58654719397776;
            453.561,0.58654719397776; 454.06,0.58914423651856; 454.56,
            0.58888453226448; 455.06,0.59044275778896; 455.558,0.59044275778896;
            456.06,0.59329950458384; 456.562,0.59278009607568; 457.059,
            0.5925203918216; 457.564,0.59407861734608; 458.061,0.5977144769032;
            458.561,0.5977144769032; 459.06,0.59745477264912; 459.562,
            0.59667565988688; 460.06,0.59875329391952; 460.56,0.5964159556328;
            461.062,0.59200098331344; 461.562,0.59485773010832; 462.066,
            0.5860277854696; 462.569,0.58680689823184; 463.06,0.58784571524816;
            463.562,0.58628748972368; 464.063,0.58706660248592; 464.561,
            0.59096216629712; 465.06,0.58940394077264; 465.563,0.58784571524816;
            466.06,0.58784571524816; 466.562,0.5860277854696; 467.061,
            0.5847292641992; 467.563,0.58680689823184; 468.062,0.58732630674;
            468.564,0.58732630674; 469.064,0.59200098331344; 469.563,
            0.59096216629712; 470.063,0.59148157480528; 470.562,
            0.59148157480528; 471.062,0.59459802585424; 471.563,
            0.59589654712464; 472.06,0.5951174343624; 472.563,0.5925203918216;
            473.06,0.59329950458384; 473.563,0.59148157480528; 474.063,
            0.59070246204304; 474.559,0.5925203918216; 475.062,0.59096216629712;
            475.563,0.59433832160016; 476.062,0.5912218705512; 476.562,
            0.59407861734608; 477.06,0.593818913092; 477.562,0.593818913092;
            478.062,0.59355920883792; 478.562,0.59407861734608; 479.061,
            0.59329950458384; 479.562,0.5912218705512; 480.064,0.59355920883792;
            480.563,0.59303980032976; 481.061,0.59433832160016; 481.563,
            0.59459802585424; 482.061,0.59044275778896; 482.563,
            0.58940394077264; 483.062,0.58810541950224; 483.562,
            0.58836512375632; 484.061,0.58706660248592; 484.563,
            0.58914423651856; 485.061,0.59096216629712; 485.562,
            0.59407861734608; 486.061,0.59303980032976; 486.561,
            0.59459802585424; 487.062,0.59433832160016; 487.562,
            0.59485773010832; 488.061,0.59407861734608; 488.563,0.593818913092;
            489.063,0.59226068756752; 489.563,0.59278009607568; 490.062,
            0.59226068756752; 490.563,0.59849358966544; 491.063,
            0.59615625137872; 491.562,0.59407861734608; 492.061,
            0.59589654712464; 492.562,0.59355920883792; 493.062,
            0.59485773010832; 493.562,0.5951174343624; 494.061,0.5951174343624;
            494.562,0.59200098331344; 495.062,0.5925203918216; 495.562,
            0.58966364502672; 496.062,0.5899233492808; 496.563,0.5899233492808;
            497.063,0.59148157480528; 497.561,0.58966364502672; 498.063,
            0.59070246204304; 498.563,0.59355920883792; 499.063,
            0.59226068756752; 499.562,0.59278009607568; 500.062,0.5925203918216;
            500.561,0.58940394077264; 501.063,0.59018305353488; 501.563,
            0.58784571524816; 502.062,0.58914423651856; 502.562,
            0.59018305353488; 503.061,0.58940394077264; 503.563,
            0.59226068756752; 504.063,0.59226068756752; 504.562,
            0.59459802585424; 505.062,0.59174127905936; 505.565,
            0.59226068756752; 506.062,0.59070246204304; 506.563,0.5925203918216;
            507.06,0.59433832160016; 507.562,0.5899233492808; 508.064,
            0.59174127905936; 508.564,0.59563684287056; 509.061,
            0.59459802585424; 509.562,0.59278009607568; 510.059,0.5912218705512;
            510.563,0.593818913092; 511.062,0.59200098331344; 511.56,
            0.59174127905936; 512.062,0.5951174343624; 512.561,0.59433832160016;
            513.061,0.5951174343624; 513.564,0.59433832160016; 514.059,
            0.59927270242768; 514.562,0.59693536414096; 515.059,0.5990129981736;
            515.564,0.59667565988688; 516.064,0.5886248280104; 516.563,
            0.58966364502672; 517.06,0.58914423651856; 517.562,0.58680689823184;
            518.062,0.5886248280104; 518.562,0.58784571524816; 519.062,
            0.59148157480528; 519.562,0.58784571524816; 520.062,
            0.58810541950224; 520.564,0.59070246204304; 521.062,
            0.59719506839504; 521.563,0.59485773010832; 522.061,0.5951174343624;
            522.562,0.59563684287056; 523.06,0.59797418115728; 523.563,
            0.60005181518992; 524.063,0.5990129981736; 524.561,0.59927270242768;
            525.062,0.59745477264912; 525.562,0.5951174343624; 526.062,
            0.59018305353488; 526.561,0.58914423651856; 527.063,
            0.58654719397776; 527.562,0.58966364502672; 528.06,0.59148157480528;
            528.574,0.5951174343624; 529.061,0.5899233492808; 529.562,
            0.59303980032976; 530.063,0.59174127905936; 530.562,
            0.59433832160016; 531.061,0.59563684287056; 531.562,
            0.59719506839504; 532.064,0.59745477264912; 532.561,
            0.59459802585424; 533.063,0.59433832160016; 533.558,
            0.59329950458384; 534.063,0.59485773010832; 534.561,0.5925203918216;
            535.061,0.59278009607568; 535.563,0.59200098331344; 536.062,
            0.5925203918216; 536.563,0.58966364502672; 537.062,0.5925203918216;
            537.561,0.59226068756752; 538.061,0.59226068756752; 538.559,
            0.59407861734608; 539.064,0.59303980032976; 539.561,
            0.59433832160016; 540.061,0.59200098331344; 540.562,
            0.59070246204304; 541.063,0.59226068756752; 541.563,0.5925203918216;
            542.063,0.59459802585424; 542.562,0.59174127905936; 543.064,
            0.59407861734608; 543.561,0.58966364502672; 544.063,
            0.59200098331344; 544.561,0.59745477264912; 545.062,0.5951174343624;
            545.562,0.59589654712464; 546.061,0.593818913092; 546.563,
            0.59823388541136; 547.061,0.593818913092; 547.561,0.59278009607568;
            548.062,0.59589654712464; 548.562,0.59537713861648; 549.062,
            0.59459802585424; 549.564,0.59459802585424; 550.062,0.593818913092;
            550.561,0.5912218705512; 551.062,0.5912218705512; 551.561,
            0.5925203918216; 552.063,0.58966364502672; 552.56,0.59615625137872;
            553.063,0.59485773010832; 553.562,0.59278009607568; 554.062,
            0.59719506839504; 554.562,0.593818913092; 555.062,0.59278009607568;
            555.562,0.5925203918216; 556.063,0.59459802585424; 556.563,
            0.5951174343624; 557.064,0.5977144769032; 557.561,0.59693536414096;
            558.059,0.59849358966544; 558.563,0.60368767474704; 559.06,
            0.60264885773072; 559.563,0.60005181518992; 560.062,
            0.59745477264912; 560.563,0.59148157480528; 561.063,
            0.59044275778896; 561.56,0.5925203918216; 562.177,0.59355920883792;
            562.563,0.59044275778896; 563.062,0.5899233492808; 563.562,
            0.59148157480528; 564.062,0.59355920883792; 564.562,
            0.59329950458384; 565.062,0.59070246204304; 565.563,
            0.59355920883792; 566.063,0.59148157480528; 566.563,
            0.59355920883792; 567.061,0.59355920883792; 567.563,
            0.59485773010832; 568.064,0.59355920883792; 568.562,
            0.59485773010832; 569.063,0.59355920883792; 569.563,
            0.59433832160016; 570.062,0.59485773010832; 570.562,
            0.59303980032976; 571.062,0.59537713861648; 571.564,
            0.59537713861648; 572.062,0.5964159556328; 572.563,0.5964159556328;
            573.062,0.59563684287056; 573.561,0.59563684287056; 574.059,
            0.59979211093584; 574.564,0.5951174343624; 575.063,0.59433832160016;
            575.561,0.59303980032976; 576.06,0.59226068756752; 576.56,
            0.59070246204304; 577.06,0.59875329391952; 577.56,0.59485773010832;
            578.058,0.59667565988688; 578.56,0.59719506839504; 579.06,
            0.59667565988688; 579.559,0.59226068756752; 580.063,0.5899233492808;
            580.563,0.5899233492808; 581.063,0.59226068756752; 581.56,
            0.59278009607568; 582.062,0.59823388541136; 582.562,
            0.60005181518992; 583.062,0.59797418115728; 583.563,
            0.59797418115728; 584.061,0.59693536414096; 584.562,0.5964159556328;
            585.062,0.59537713861648; 585.563,0.59615625137872; 586.061,
            0.59797418115728; 586.564,0.59485773010832; 587.062,
            0.59407861734608; 587.561,0.59459802585424; 588.061,
            0.59459802585424; 588.562,0.59433832160016; 589.062,
            0.59615625137872; 589.562,0.593818913092; 590.063,0.59537713861648;
            590.563,0.59355920883792; 591.063,0.59148157480528; 591.562,
            0.59407861734608; 592.063,0.59278009607568; 592.562,
            0.59200098331344; 593.063,0.59226068756752; 593.562,0.5912218705512;
            594.063,0.59485773010832; 594.563,0.5951174343624; 595.063,
            0.59563684287056; 595.56,0.5964159556328; 596.062,0.59433832160016;
            596.563,0.59433832160016; 597.063,0.59355920883792; 597.562,
            0.59667565988688; 598.06,0.59563684287056; 598.562,0.59927270242768;
            599.063,0.59719506839504; 599.562,0.5964159556328; 600.064,
            0.59433832160016; 600.562,0.5951174343624; 601.062,0.5925203918216;
            601.561,0.59667565988688; 602.062,0.59329950458384; 602.563,
            0.5951174343624; 603.062,0.59459802585424; 603.561,0.59745477264912;
            604.064,0.59459802585424; 604.562,0.5951174343624; 605.061,
            0.59459802585424; 605.564,0.59589654712464; 606.063,
            0.59745477264912; 606.563,0.59667565988688; 607.063,
            0.59693536414096; 607.562,0.60057122369808; 608.063,
            0.59433832160016; 608.561,0.59433832160016; 609.061,
            0.59459802585424; 609.564,0.59226068756752; 610.062,0.5964159556328;
            610.563,0.5964159556328; 611.062,0.59303980032976; 611.562,
            0.59433832160016; 612.062,0.5925203918216; 612.563,0.59148157480528;
            613.061,0.59044275778896; 613.562,0.59148157480528; 614.064,
            0.59329950458384; 614.563,0.59485773010832; 615.062,
            0.59329950458384; 615.562,0.59537713861648; 616.062,0.593818913092;
            616.563,0.59667565988688; 617.063,0.59589654712464; 617.564,
            0.59563684287056; 618.061,0.60135033646032; 618.561,0.5990129981736;
            619.062,0.59745477264912; 619.563,0.59459802585424; 620.063,
            0.59797418115728; 620.56,0.59407861734608; 621.063,0.59563684287056;
            621.56,0.59719506839504; 622.061,0.5925203918216; 622.562,
            0.59693536414096; 623.06,0.5925203918216; 623.562,0.59355920883792;
            624.063,0.59667565988688; 624.56,0.59615625137872; 625.063,
            0.59200098331344; 625.563,0.59485773010832; 626.064,0.5964159556328;
            626.563,0.59459802585424; 627.062,0.5886248280104; 627.563,
            0.5925203918216; 628.062,0.59797418115728; 628.562,0.60057122369808;
            629.062,0.59719506839504; 629.561,0.60212944922256; 630.062,
            0.60368767474704; 630.563,0.60057122369808; 631.062,
            0.59849358966544; 631.561,0.6042070832552; 632.062,0.59979211093584;
            632.561,0.60446678750928; 633.062,0.6029085619848; 633.562,
            0.5977144769032; 634.06,0.59953240668176; 634.562,0.5951174343624;
            635.058,0.59875329391952; 635.562,0.59823388541136; 636.062,
            0.593818913092; 636.559,0.59485773010832; 637.06,0.593818913092;
            637.562,0.59096216629712; 638.062,0.5912218705512; 638.562,
            0.59433832160016; 639.063,0.59459802585424; 639.562,
            0.59537713861648; 640.062,0.59407861734608; 640.563,
            0.59719506839504; 641.063,0.59719506839504; 641.564,
            0.60057122369808; 642.063,0.59849358966544; 642.562,
            0.60109063220624; 643.06,0.60083092795216; 643.562,0.60005181518992;
            644.062,0.59745477264912; 644.561,0.59927270242768; 645.064,
            0.59979211093584; 645.563,0.59875329391952; 646.062,
            0.60186974496848; 646.564,0.60212944922256; 647.063,0.6016100407144;
            647.56,0.60264885773072; 648.063,0.60498619601744; 648.562,
            0.60109063220624; 649.063,0.59953240668176; 649.562,
            0.59823388541136; 650.063,0.59433832160016; 650.559,
            0.59459802585424; 651.062,0.59174127905936; 651.559,0.5912218705512;
            652.06,0.59200098331344; 652.563,0.59407861734608; 653.062,
            0.59797418115728; 653.564,0.59953240668176; 654.062,
            0.60005181518992; 654.563,0.60005181518992; 655.062,
            0.59953240668176; 655.562,0.5925203918216; 656.06,0.5964159556328;
            656.563,0.5925203918216; 657.063,0.59485773010832; 657.561,
            0.59303980032976; 658.062,0.59278009607568; 658.559,
            0.59303980032976; 659.06,0.59355920883792; 659.559,0.59485773010832;
            660.06,0.59667565988688; 660.561,0.59200098331344; 661.06,
            0.59667565988688; 661.56,0.59226068756752; 662.059,0.593818913092;
            662.564,0.59537713861648; 663.064,0.59355920883792; 663.56,
            0.593818913092; 664.063,0.59200098331344; 664.562,0.59433832160016;
            665.06,0.59433832160016; 665.56,0.5925203918216; 666.06,
            0.593818913092; 666.56,0.5912218705512; 667.06,0.593818913092;
            667.56,0.59589654712464; 668.06,0.59537713861648; 668.56,
            0.59485773010832; 669.06,0.59433832160016; 669.562,0.59979211093584;
            670.062,0.59485773010832; 670.563,0.5990129981736; 671.059,
            0.59823388541136; 671.563,0.5964159556328; 672.062,0.59537713861648;
            672.559,0.59485773010832; 673.06,0.60083092795216; 673.56,
            0.59693536414096; 674.059,0.600311519444; 674.56,0.59979211093584;
            675.06,0.5990129981736; 675.56,0.59823388541136; 676.06,
            0.59693536414096; 676.56,0.59589654712464; 677.06,0.59797418115728;
            677.562,0.59797418115728; 678.062,0.59589654712464; 678.563,
            0.59823388541136; 679.064,0.59485773010832; 679.562,
            0.60083092795216; 680.062,0.60005181518992; 680.563,0.5990129981736;
            681.063,0.60212944922256; 681.559,0.59979211093584; 682.062,
            0.60186974496848; 682.561,0.59667565988688; 683.063,0.593818913092;
            683.56,0.5964159556328; 684.063,0.59200098331344; 684.564,
            0.59329950458384; 685.062,0.59433832160016; 685.564,0.5964159556328;
            686.062,0.5951174343624; 686.56,0.59875329391952; 687.063,
            0.6042070832552; 687.561,0.60394737900112; 688.06,0.60083092795216;
            688.561,0.60446678750928; 689.059,0.60342797049296; 689.559,
            0.60342797049296; 690.064,0.60342797049296; 690.563,
            0.59875329391952; 691.061,0.59719506839504; 691.564,
            0.59485773010832; 692.059,0.59485773010832; 692.561,
            0.59278009607568; 693.06,0.59407861734608; 693.562,0.59953240668176;
            694.061,0.59693536414096; 694.559,0.5964159556328; 695.06,
            0.59797418115728; 695.56,0.59226068756752; 696.062,0.59355920883792;
            696.561,0.59174127905936; 697.061,0.59303980032976; 697.561,
            0.59433832160016; 698.061,0.593818913092; 698.559,0.59693536414096;
            699.062,0.59693536414096; 699.562,0.59433832160016; 700.062,
            0.59200098331344; 700.562,0.59329950458384; 701.062,
            0.59355920883792; 701.562,0.593818913092; 702.062,0.59407861734608;
            702.56,0.59849358966544; 703.062,0.59693536414096; 703.563,
            0.5977144769032; 704.063,0.5990129981736; 704.563,0.6029085619848;
            705.063,0.59979211093584; 705.562,0.60109063220624; 706.063,
            0.60005181518992; 706.563,0.59823388541136; 707.063,
            0.60057122369808; 707.559,0.60212944922256; 708.063,
            0.59797418115728; 708.56,0.60109063220624; 709.061,0.59719506839504;
            709.56,0.59589654712464; 710.059,0.59797418115728; 710.56,
            0.59745477264912; 711.059,0.59823388541136; 711.561,
            0.59797418115728; 712.062,0.59719506839504; 712.559,
            0.59823388541136; 713.063,0.59693536414096; 713.562,
            0.59979211093584; 714.063,0.60109063220624; 714.563,
            0.59953240668176; 715.062,0.5990129981736; 715.563,0.59693536414096;
            716.062,0.59667565988688; 716.562,0.59953240668176; 717.063,
            0.59953240668176; 717.559,0.60083092795216; 718.063,
            0.59927270242768; 718.562,0.600311519444; 719.062,0.60316826623888;
            719.56,0.6029085619848; 720.06,0.60083092795216; 720.562,
            0.60238915347664; 721.064,0.59823388541136; 721.563,
            0.59537713861648; 722.063,0.5964159556328; 722.559,0.60212944922256;
            723.062,0.59823388541136; 723.561,0.60083092795216; 724.061,
            0.59823388541136; 724.563,0.6016100407144; 725.062,0.60005181518992;
            725.562,0.59953240668176; 726.061,0.59693536414096; 726.562,
            0.59953240668176; 727.063,0.59433832160016; 727.56,0.59719506839504;
            728.061,0.59615625137872; 728.56,0.59407861734608; 729.063,
            0.5964159556328; 729.56,0.59979211093584; 730.063,0.5990129981736;
            730.562,0.60109063220624; 731.063,0.6042070832552; 731.563,
            0.59927270242768; 732.062,0.59979211093584; 732.561,0.5977144769032;
            733.062,0.59745477264912; 733.562,0.59797418115728; 734.062,
            0.59693536414096; 734.564,0.5977144769032; 735.063,0.600311519444;
            735.56,0.60135033646032; 736.062,0.59875329391952; 736.56,
            0.59849358966544; 737.063,0.59745477264912; 737.56,0.5964159556328;
            738.062,0.59797418115728; 738.562,0.5990129981736; 739.062,
            0.59823388541136; 739.561,0.59719506839504; 740.062,
            0.59953240668176; 740.562,0.60109063220624; 741.062,
            0.59953240668176; 741.563,0.59797418115728; 742.063,0.5977144769032;
            742.561,0.5990129981736; 743.063,0.59979211093584; 743.562,
            0.60186974496848; 744.062,0.60109063220624; 744.56,0.60109063220624;
            745.061,0.59927270242768; 745.563,0.59927270242768; 746.061,
            0.60135033646032; 746.562,0.59979211093584; 747.061,
            0.59823388541136; 747.56,0.5990129981736; 748.061,0.59797418115728;
            748.561,0.59849358966544; 749.061,0.60238915347664; 749.562,
            0.600311519444; 750.061,0.60057122369808; 750.56,0.60186974496848;
            751.062,0.60057122369808; 751.559,0.5990129981736; 752.061,
            0.59719506839504; 752.56,0.59719506839504; 753.06,0.59667565988688;
            753.56,0.59589654712464; 754.06,0.59589654712464; 754.56,
            0.59044275778896; 755.06,0.59407861734608; 755.559,0.59927270242768;
            756.06,0.59875329391952; 756.563,0.59823388541136; 757.06,
            0.59979211093584; 757.561,0.60057122369808; 758.059,
            0.60057122369808; 758.562,0.59849358966544; 759.061,0.600311519444;
            759.563,0.59979211093584; 760.063,0.60005181518992; 760.563,
            0.59953240668176; 761.062,0.600311519444; 761.563,0.60446678750928;
            762.063,0.60057122369808; 762.561,0.6029085619848; 763.06,
            0.60109063220624; 763.563,0.60005181518992; 764.063,
            0.59693536414096; 764.562,0.59615625137872; 765.063,
            0.59226068756752; 765.56,0.59303980032976; 766.063,0.5899233492808;
            766.563,0.59096216629712; 767.063,0.59148157480528; 767.562,
            0.59303980032976; 768.062,0.593818913092; 768.562,0.59537713861648;
            769.063,0.5951174343624; 769.562,0.5951174343624; 770.062,
            0.5990129981736; 770.56,0.59719506839504; 771.061,0.60057122369808;
            771.564,0.5964159556328; 772.063,0.59615625137872; 772.563,
            0.5951174343624; 773.063,0.59693536414096; 773.563,0.59589654712464;
            774.062,0.59589654712464; 774.562,0.59459802585424; 775.063,
            0.59589654712464; 775.561,0.59485773010832; 776.063,
            0.59537713861648; 776.562,0.59563684287056; 777.061,
            0.59355920883792; 777.562,0.59485773010832; 778.064,
            0.59459802585424; 778.561,0.59096216629712; 779.063,0.5964159556328;
            779.567,0.59303980032976; 780.063,0.59589654712464; 780.562,
            0.59745477264912; 781.063,0.60083092795216; 781.562,
            0.60654442154192; 782.062,0.60732353430416; 782.564,
            0.60446678750928; 783.063,0.60394737900112; 783.563,
            0.60472649176336; 784.065,0.59953240668176; 784.563,
            0.60005181518992; 785.063,0.60109063220624; 785.562,
            0.59953240668176; 786.063,0.5977144769032; 786.563,0.5977144769032;
            787.062,0.59615625137872; 787.563,0.59537713861648; 788.062,
            0.59433832160016; 788.561,0.59667565988688; 789.06,0.59745477264912;
            789.56,0.59537713861648; 790.062,0.59589654712464; 790.561,
            0.59537713861648; 791.06,0.59745477264912; 791.56,0.59667565988688;
            792.059,0.59849358966544; 792.56,0.59693536414096; 793.059,
            0.59667565988688; 793.562,0.59823388541136; 794.061,0.600311519444;
            794.56,0.60109063220624; 795.061,0.59693536414096; 795.561,
            0.59953240668176; 796.061,0.600311519444; 796.56,0.59927270242768;
            797.062,0.59953240668176; 797.561,0.60135033646032; 798.061,
            0.5964159556328; 798.561,0.59927270242768; 799.062,0.59823388541136;
            799.56,0.59823388541136; 800.061,0.59849358966544; 800.561,
            0.59563684287056; 801.061,0.59433832160016; 801.561,
            0.59459802585424; 802.062,0.59745477264912; 802.56,0.60005181518992;
            803.059,0.59953240668176; 803.56,0.600311519444; 804.061,
            0.59849358966544; 804.561,0.59875329391952; 805.061,
            0.59979211093584; 805.561,0.59849358966544; 806.061,
            0.59849358966544; 806.561,0.59615625137872; 807.061,
            0.59797418115728; 807.561,0.59745477264912; 808.06,0.5977144769032;
            808.562,0.59797418115728; 809.062,0.59745477264912; 809.561,
            0.59589654712464; 810.061,0.59719506839504; 810.562,
            0.59719506839504; 811.06,0.59433832160016; 811.56,0.59200098331344;
            812.063,0.59355920883792; 812.561,0.59226068756752; 813.061,
            0.593818913092; 813.562,0.58966364502672; 814.062,0.5951174343624;
            814.56,0.59563684287056; 815.06,0.59485773010832; 815.56,
            0.59667565988688; 816.062,0.59797418115728; 816.563,0.5977144769032;
            817.06,0.59979211093584; 817.56,0.60109063220624; 818.06,
            0.59745477264912; 818.56,0.60212944922256; 819.061,0.60238915347664;
            819.56,0.60212944922256; 820.06,0.5977144769032; 820.561,
            0.59849358966544; 821.061,0.59927270242768; 821.56,0.59927270242768;
            822.061,0.59693536414096; 822.561,0.59953240668176; 823.061,
            0.5964159556328; 823.56,0.59953240668176; 824.061,0.59927270242768;
            824.56,0.5990129981736; 825.059,0.59875329391952; 825.56,
            0.59355920883792; 826.06,0.59693536414096; 826.56,0.5951174343624;
            827.061,0.5990129981736; 827.561,0.59875329391952; 828.06,
            0.5964159556328; 828.561,0.59563684287056; 829.06,0.59485773010832;
            829.562,0.59615625137872; 830.061,0.5977144769032; 830.561,
            0.59719506839504; 831.06,0.5977144769032; 831.56,0.59537713861648;
            832.061,0.59485773010832; 832.56,0.59563684287056; 833.063,
            0.59667565988688; 833.56,0.59667565988688; 834.061,0.59823388541136;
            834.561,0.59615625137872; 835.063,0.59667565988688; 835.56,
            0.59563684287056; 836.061,0.59693536414096; 836.561,
            0.59667565988688; 837.06,0.5964159556328; 837.563,0.59667565988688;
            838.062,0.5977144769032; 838.561,0.59278009607568; 839.062,
            0.59407861734608; 839.561,0.59044275778896; 840.063,0.5912218705512;
            840.559,0.59174127905936; 841.061,0.5912218705512; 841.562,
            0.5899233492808; 842.064,0.59226068756752; 842.561,0.59459802585424;
            843.061,0.59148157480528; 843.564,0.59589654712464; 844.063,
            0.59355920883792; 844.563,0.59485773010832; 845.062,
            0.59226068756752; 845.56,0.59667565988688; 846.064,0.5977144769032;
            846.562,0.5977144769032; 847.064,0.59667565988688; 847.56,
            0.5951174343624; 848.064,0.5964159556328; 848.563,0.59433832160016;
            849.063,0.59823388541136; 849.563,0.59719506839504; 850.06,
            0.59667565988688; 850.562,0.59797418115728; 851.062,
            0.59615625137872; 851.563,0.59303980032976; 852.063,
            0.59200098331344; 852.561,0.59278009607568; 853.061,
            0.59459802585424; 853.564,0.59303980032976; 854.064,
            0.59615625137872; 854.562,0.59537713861648; 855.062,0.5977144769032;
            855.564,0.59589654712464; 856.061,0.59433832160016; 856.563,
            0.59823388541136; 857.063,0.59563684287056; 857.564,
            0.59849358966544; 858.064,0.59537713861648; 858.561,
            0.59875329391952; 859.063,0.59485773010832; 859.562,
            0.59667565988688; 860.063,0.59433832160016; 860.563,
            0.59459802585424; 861.06,0.59174127905936; 861.562,0.59459802585424;
            862.065,0.59693536414096; 862.564,0.59615625137872; 863.061,
            0.59875329391952; 863.563,0.59563684287056; 864.063,0.5951174343624;
            864.561,0.59537713861648; 865.062,0.59407861734608; 865.564,
            0.59537713861648; 866.063,0.59329950458384; 866.561,
            0.59303980032976; 867.062,0.593818913092; 867.563,0.59278009607568;
            868.062,0.59485773010832; 868.562,0.59589654712464; 869.063,
            0.59797418115728; 869.562,0.59615625137872; 870.063,
            0.59875329391952; 870.56,0.60005181518992; 871.064,0.60135033646032;
            871.564,0.59563684287056; 872.062,0.59485773010832; 872.562,
            0.593818913092; 873.063,0.5925203918216; 873.562,0.59537713861648;
            874.062,0.59745477264912; 874.56,0.59693536414096; 875.064,
            0.59719506839504; 875.562,0.600311519444; 876.064,0.59823388541136;
            876.563,0.59927270242768; 877.063,0.60238915347664; 877.562,
            0.59953240668176; 878.063,0.59927270242768; 878.564,
            0.60472649176336; 879.062,0.60005181518992; 879.563,0.6029085619848;
            880.063,0.59875329391952; 880.564,0.60212944922256; 881.061,
            0.60342797049296; 881.563,0.60005181518992; 882.063,
            0.60212944922256; 882.564,0.60316826623888; 883.063,
            0.60446678750928; 883.562,0.6042070832552; 884.065,0.60109063220624;
            884.563,0.60135033646032; 885.063,0.60186974496848; 885.564,
            0.60264885773072; 886.064,0.60368767474704; 886.562,0.6055056045256;
            887.063,0.60732353430416; 887.564,0.60498619601744; 888.062,
            0.60212944922256; 888.563,0.60238915347664; 889.063,
            0.60212944922256; 889.564,0.60238915347664; 890.063,
            0.60186974496848; 890.562,0.600311519444; 891.062,0.60212944922256;
            891.563,0.60368767474704; 892.063,0.60446678750928; 892.564,
            0.6055056045256; 893.063,0.60212944922256; 893.564,0.60394737900112;
            894.063,0.60368767474704; 894.563,0.60576530877968; 895.062,
            0.60368767474704; 895.565,0.60238915347664; 896.062,
            0.60109063220624; 896.563,0.60135033646032; 897.063,
            0.60342797049296; 897.565,0.60212944922256; 898.062,
            0.60057122369808; 898.563,0.60109063220624; 899.064,
            0.59927270242768; 899.563,0.59849358966544; 900.063,
            0.60005181518992; 900.563,0.59927270242768; 901.063,0.600311519444;
            901.564,0.60109063220624; 902.065,0.60212944922256; 902.562,
            0.60186974496848; 903.063,0.59485773010832; 903.564,
            0.59589654712464; 904.063,0.60109063220624; 904.563,
            0.59693536414096; 905.063,0.5951174343624; 905.562,0.59927270242768;
            906.063,0.5964159556328; 906.562,0.59927270242768; 907.062,
            0.60109063220624; 907.564,0.59875329391952; 908.064,
            0.60135033646032; 908.564,0.59927270242768; 909.062,0.600311519444;
            909.563,0.60057122369808; 910.062,0.600311519444; 910.56,
            0.59927270242768; 911.063,0.6029085619848; 911.563,0.60238915347664;
            912.064,0.6016100407144; 912.562,0.60005181518992; 913.063,
            0.6016100407144; 913.563,0.60368767474704; 914.063,0.60264885773072;
            914.564,0.60212944922256; 915.064,0.60083092795216; 915.563,
            0.60264885773072; 916.063,0.60628471728784; 916.564,0.6029085619848;
            917.063,0.60524590027152; 917.565,0.60446678750928; 918.063,
            0.60238915347664; 918.564,0.6016100407144; 919.065,0.5990129981736;
            919.564,0.60186974496848; 920.065,0.60264885773072; 920.562,
            0.60524590027152; 921.063,0.60057122369808; 921.565,
            0.60394737900112; 922.063,0.60602501303376; 922.564,
            0.60472649176336; 923.065,0.60446678750928; 923.562,0.6042070832552;
            924.062,0.60264885773072; 924.564,0.60524590027152; 925.061,
            0.60654442154192; 925.562,0.60628471728784; 926.062,
            0.60784294281232; 926.559,0.60914146408272; 927.063,
            0.61043998535312; 927.565,0.60862205557456; 928.063,0.606804125796;
            928.563,0.606804125796; 929.064,0.60654442154192; 929.563,
            0.60628471728784; 930.064,0.61251761938576; 930.564,0.6106996896072;
            931.064,0.60732353430416; 931.563,0.60446678750928; 932.064,
            0.60212944922256; 932.563,0.60498619601744; 933.064,
            0.60576530877968; 933.564,0.6055056045256; 934.062,0.60654442154192;
            934.563,0.60654442154192; 935.063,0.60888175982864; 935.562,
            0.60576530877968; 936.063,0.60264885773072; 936.56,0.60264885773072;
            937.06,0.6029085619848; 937.563,0.60186974496848; 938.063,
            0.60394737900112; 938.563,0.60316826623888; 939.065,0.606804125796;
            939.565,0.60316826623888; 940.064,0.60135033646032; 940.563,
            0.6029085619848; 941.065,0.60316826623888; 941.562,0.60446678750928;
            942.065,0.60238915347664; 942.562,0.60524590027152; 943.063,
            0.60602501303376; 943.563,0.60264885773072; 944.063,0.6055056045256;
            944.565,0.60238915347664; 945.063,0.60342797049296; 945.563,
            0.60135033646032; 946.064,0.6016100407144; 946.563,0.60135033646032;
            947.062,0.6042070832552; 947.565,0.60342797049296; 948.063,
            0.60342797049296; 948.564,0.60394737900112; 949.065,
            0.60316826623888; 949.564,0.60368767474704; 950.06,0.60238915347664;
            950.564,0.60316826623888; 951.065,0.60524590027152; 951.56,
            0.60342797049296; 952.06,0.60654442154192; 952.563,0.6042070832552;
            953.062,0.60394737900112; 953.563,0.60498619601744; 954.064,
            0.60135033646032; 954.563,0.59745477264912; 955.062,
            0.60005181518992; 955.563,0.59485773010832; 956.063,0.600311519444;
            956.561,0.60186974496848; 957.063,0.5990129981736; 957.563,
            0.6016100407144; 958.062,0.60342797049296; 958.564,0.60368767474704;
            959.064,0.6055056045256; 959.563,0.60472649176336; 960.063,
            0.60836235132048; 960.562,0.60212944922256; 961.062,
            0.60602501303376; 961.563,0.60498619601744; 962.061,0.6055056045256;
            962.561,0.60576530877968; 963.064,0.60602501303376; 963.562,
            0.60706383005008; 964.062,0.60498619601744; 964.564,0.6081026470664;
            965.063,0.6042070832552; 965.561,0.59719506839504; 966.064,
            0.5990129981736; 966.562,0.60057122369808; 967.063,0.6029085619848;
            967.565,0.61173850662352; 968.062,0.61485495767248; 968.563,
            0.61433554916432; 969.061,0.61277732363984; 969.563,
            0.61433554916432; 970.063,0.61251761938576; 970.564,0.6119982108776;
            971.064,0.60888175982864; 971.563,0.61303702789392; 972.063,
            0.61407584491024; 972.563,0.61251761938576; 973.061,
            0.61251761938576; 973.563,0.60836235132048; 974.063,
            0.60238915347664; 974.564,0.60654442154192; 975.063,
            0.60914146408272; 975.563,0.60836235132048; 976.063,
            0.60914146408272; 976.562,0.6094011683368; 977.064,0.60264885773072;
            977.563,0.6055056045256; 978.064,0.60732353430416; 978.563,
            0.6055056045256; 979.065,0.60342797049296; 979.563,0.60368767474704;
            980.064,0.60602501303376; 980.564,0.60576530877968; 981.061,
            0.60264885773072; 981.563,0.59953240668176; 982.063,
            0.60264885773072; 982.563,0.6042070832552; 983.063,0.59849358966544;
            983.564,0.60135033646032; 984.064,0.60394737900112; 984.564,
            0.60264885773072; 985.065,0.60394737900112; 985.562,0.6029085619848;
            986.063,0.60602501303376; 986.565,0.60316826623888; 987.064,
            0.60264885773072; 987.563,0.60732353430416; 988.062,
            0.60498619601744; 988.564,0.60836235132048; 989.064,
            0.60498619601744; 989.564,0.60264885773072; 990.064,
            0.60109063220624; 990.563,0.60732353430416; 991.064,
            0.60109063220624; 991.56,0.60576530877968; 992.063,0.60758323855824;
            992.563,0.60732353430416; 993.064,0.60238915347664; 993.563,
            0.60472649176336; 994.062,0.60264885773072; 994.564,
            0.60576530877968; 995.063,0.60212944922256; 995.563,
            0.60316826623888; 996.062,0.60394737900112; 996.563,
            0.60732353430416; 997.064,0.60135033646032; 997.564,0.6042070832552;
            998.063,0.60784294281232; 998.563,0.60732353430416; 999.062,
            0.60992057684496; 999.564,0.60888175982864; 1000.065,
            0.60888175982864; 1000.564,0.60914146408272; 1001.063,
            0.60784294281232; 1001.565,0.6094011683368; 1002.064,
            0.60472649176336; 1002.565,0.60732353430416; 1003.062,
            0.61095939386128; 1003.564,0.61095939386128; 1004.063,
            0.61407584491024; 1004.564,0.60732353430416; 1005.063,
            0.6094011683368; 1005.564,0.61225791513168; 1006.062,
            0.60576530877968; 1006.564,0.60654442154192; 1007.063,
            0.60654442154192; 1007.562,0.6042070832552; 1008.061,
            0.60472649176336; 1008.565,0.606804125796; 1009.063,
            0.60446678750928; 1009.564,0.60862205557456; 1010.063,
            0.60109063220624; 1010.563,0.6055056045256; 1011.063,
            0.60498619601744; 1011.562,0.60342797049296; 1012.063,
            0.60316826623888; 1012.564,0.60628471728784; 1013.062,
            0.60654442154192; 1013.562,0.61018028109904; 1014.063,
            0.61043998535312; 1014.564,0.60342797049296; 1015.063,
            0.60628471728784; 1015.563,0.60914146408272; 1016.064,
            0.60784294281232; 1016.563,0.6081026470664; 1017.063,
            0.60888175982864; 1017.562,0.60706383005008; 1018.06,
            0.60758323855824; 1018.563,0.6042070832552; 1019.063,0.606804125796;
            1019.563,0.6042070832552; 1020.064,0.60576530877968; 1020.564,
            0.6055056045256; 1021.063,0.606804125796; 1021.563,0.60706383005008;
            1022.062,0.6042070832552; 1022.562,0.60212944922256; 1023.06,
            0.60186974496848; 1023.564,0.60368767474704; 1024.065,
            0.6055056045256; 1024.563,0.61018028109904; 1025.064,
            0.6119982108776; 1025.563,0.61095939386128; 1026.064,
            0.60992057684496; 1026.565,0.61043998535312; 1027.063,
            0.60654442154192; 1027.565,0.60732353430416; 1028.06,
            0.60576530877968; 1028.564,0.60472649176336; 1029.062,
            0.60758323855824; 1029.564,0.6094011683368; 1030.064,
            0.60498619601744; 1030.564,0.60706383005008; 1031.064,
            0.6055056045256; 1031.564,0.6029085619848; 1032.063,
            0.60602501303376; 1032.564,0.60446678750928; 1033.06,
            0.60862205557456; 1033.563,0.60758323855824; 1034.063,
            0.60862205557456; 1034.564,0.60836235132048; 1035.064,
            0.60966087259088; 1035.562,0.60706383005008; 1036.064,
            0.61018028109904; 1036.564,0.61121909811536; 1037.062,
            0.613296732148; 1037.564,0.60888175982864; 1038.062,
            0.61147880236944; 1038.563,0.60966087259088; 1039.063,
            0.6094011683368; 1039.563,0.60862205557456; 1040.063,
            0.6081026470664; 1040.564,0.60368767474704; 1041.066,
            0.60472649176336; 1041.562,0.60238915347664; 1042.063,
            0.59979211093584; 1042.562,0.60602501303376; 1043.064,
            0.60135033646032; 1043.563,0.60758323855824; 1044.063,
            0.60368767474704; 1044.561,0.60602501303376; 1045.063,
            0.60498619601744; 1045.563,0.60888175982864; 1046.064,
            0.60524590027152; 1046.562,0.606804125796; 1047.063,
            0.60654442154192; 1047.563,0.60368767474704; 1048.062,
            0.60628471728784; 1048.562,0.60654442154192; 1049.064,
            0.60732353430416; 1049.563,0.60446678750928; 1050.062,
            0.6042070832552; 1050.563,0.6042070832552; 1051.063,
            0.60264885773072; 1051.564,0.60576530877968; 1052.063,
            0.60342797049296; 1052.563,0.6042070832552; 1053.062,
            0.60498619601744; 1053.563,0.60472649176336; 1054.061,
            0.60706383005008; 1054.563,0.60498619601744; 1055.064,
            0.60758323855824; 1055.564,0.6081026470664; 1056.064,
            0.60888175982864; 1056.564,0.606804125796; 1057.063,
            0.60992057684496; 1057.565,0.6081026470664; 1058.063,
            0.60914146408272; 1058.565,0.61147880236944; 1059.064,
            0.61043998535312; 1059.565,0.60992057684496; 1060.062,
            0.61095939386128; 1060.563,0.61251761938576; 1061.064,
            0.61095939386128; 1061.563,0.6106996896072; 1062.063,0.613296732148;
            1062.563,0.6119982108776; 1063.065,0.61043998535312; 1063.562,
            0.61433554916432; 1064.063,0.6106996896072; 1064.564,
            0.60966087259088; 1065.063,0.60862205557456; 1065.564,
            0.60784294281232; 1066.064,0.60862205557456; 1066.565,
            0.60602501303376; 1067.064,0.60706383005008; 1067.565,
            0.606804125796; 1068.064,0.6081026470664; 1068.564,0.60888175982864;
            1069.064,0.60836235132048; 1069.564,0.60992057684496; 1070.064,
            0.61381614065616; 1070.564,0.61147880236944; 1071.064,
            0.61225791513168; 1071.562,0.60836235132048; 1072.063,
            0.61121909811536; 1072.565,0.61173850662352; 1073.064,
            0.61407584491024; 1073.564,0.61095939386128; 1074.063,
            0.61277732363984; 1074.564,0.6106996896072; 1075.062,
            0.6119982108776; 1075.562,0.61251761938576; 1076.063,
            0.61511466192656; 1076.562,0.61355643640208; 1077.064,
            0.61563407043472; 1077.562,0.61615347894288; 1078.063,
            0.61823111297552; 1078.562,0.6171922959592; 1079.064,
            0.61745200021328; 1079.564,0.61797140872144; 1080.064,
            0.61693259170512; 1080.562,0.61511466192656; 1081.064,
            0.61407584491024; 1081.56,0.61615347894288; 1082.064,
            0.61381614065616; 1082.565,0.61303702789392; 1083.064,
            0.6106996896072; 1083.563,0.60836235132048; 1084.064,
            0.60758323855824; 1084.562,0.60836235132048; 1085.064,
            0.6106996896072; 1085.564,0.60992057684496; 1086.064,
            0.60914146408272; 1086.564,0.60862205557456; 1087.062,
            0.60888175982864; 1087.563,0.60732353430416; 1088.062,
            0.60784294281232; 1088.563,0.60888175982864; 1089.064,
            0.61173850662352; 1089.562,0.61225791513168; 1090.063,
            0.61355643640208; 1090.564,0.61277732363984; 1091.065,
            0.6119982108776; 1091.561,0.61173850662352; 1092.063,
            0.61095939386128; 1092.563,0.6145952534184; 1093.064,
            0.61277732363984; 1093.564,0.61407584491024; 1094.064,
            0.61615347894288; 1094.563,0.61641318319696; 1095.063,
            0.61173850662352; 1095.563,0.60836235132048; 1096.065,
            0.60966087259088; 1096.564,0.6055056045256; 1097.063,
            0.60446678750928; 1097.564,0.60706383005008; 1098.062,
            0.60706383005008; 1098.563,0.6094011683368; 1099.063,
            0.6055056045256; 1099.563,0.60836235132048; 1100.064,
            0.6119982108776; 1100.563,0.61173850662352; 1101.064,
            0.61407584491024; 1101.564,0.61381614065616; 1102.063,
            0.61225791513168; 1102.563,0.61018028109904; 1103.063,
            0.6106996896072; 1103.565,0.61095939386128; 1104.064,
            0.61173850662352; 1104.564,0.61511466192656; 1105.065,
            0.61433554916432; 1105.562,0.61277732363984; 1106.064,
            0.61407584491024; 1106.563,0.6145952534184; 1107.063,
            0.61667288745104; 1107.561,0.61563407043472; 1108.062,
            0.61251761938576; 1108.563,0.60966087259088; 1109.061,
            0.61381614065616; 1109.563,0.6106996896072; 1110.063,
            0.6119982108776; 1110.562,0.613296732148; 1111.061,0.61173850662352;
            1111.56,0.61511466192656; 1112.059,0.61277732363984; 1112.561,
            0.61693259170512; 1113.06,0.61225791513168; 1113.561,
            0.61485495767248; 1114.062,0.61095939386128; 1114.56,
            0.61277732363984; 1115.061,0.61251761938576; 1115.561,
            0.6145952534184; 1116.061,0.61251761938576; 1116.562,
            0.61251761938576; 1117.061,0.61485495767248; 1117.563,
            0.61433554916432; 1118.063,0.61095939386128; 1118.563,
            0.6119982108776; 1119.064,0.60992057684496; 1119.563,
            0.60966087259088; 1120.063,0.6081026470664; 1120.563,0.606804125796;
            1121.063,0.60706383005008; 1121.563,0.60472649176336; 1122.063,
            0.606804125796; 1122.565,0.60576530877968; 1123.064,
            0.60914146408272; 1123.56,0.60888175982864; 1124.063,
            0.60784294281232; 1124.564,0.60498619601744; 1125.064,
            0.60628471728784; 1125.564,0.60836235132048; 1126.063,
            0.60966087259088; 1126.563,0.6081026470664; 1127.064,
            0.6094011683368; 1127.564,0.6094011683368; 1128.064,
            0.60992057684496; 1128.564,0.60758323855824; 1129.063,
            0.606804125796; 1129.565,0.60706383005008; 1130.064,
            0.60862205557456; 1130.564,0.6055056045256; 1131.064,
            0.6055056045256; 1131.565,0.60836235132048; 1132.064,
            0.60576530877968; 1132.564,0.6042070832552; 1133.065,
            0.60628471728784; 1133.562,0.6081026470664; 1134.064,
            0.61147880236944; 1134.563,0.61251761938576; 1135.065,
            0.61277732363984; 1135.564,0.61251761938576; 1136.064,
            0.61355643640208; 1136.563,0.61251761938576; 1137.065,
            0.61303702789392; 1137.565,0.6119982108776; 1138.064,
            0.60732353430416; 1138.562,0.60706383005008; 1139.061,
            0.60602501303376; 1139.564,0.60654442154192; 1140.063,
            0.606804125796; 1140.564,0.6094011683368; 1141.064,0.61043998535312;
            1141.564,0.60992057684496; 1142.065,0.61121909811536; 1142.563,
            0.6081026470664; 1143.064,0.61095939386128; 1143.564,
            0.60992057684496; 1144.064,0.6081026470664; 1144.563,
            0.60992057684496; 1145.064,0.60914146408272; 1145.563,
            0.6094011683368; 1146.063,0.61043998535312; 1146.565,
            0.60992057684496; 1147.063,0.60914146408272; 1147.564,
            0.61043998535312; 1148.063,0.60992057684496; 1148.563,
            0.61225791513168; 1149.062,0.61018028109904; 1149.563,
            0.61303702789392; 1150.064,0.61303702789392; 1150.564,
            0.61095939386128; 1151.063,0.60992057684496; 1151.564,
            0.61018028109904; 1152.062,0.60966087259088; 1152.565,
            0.61173850662352; 1153.063,0.61121909811536; 1153.563,
            0.613296732148; 1154.063,0.61277732363984; 1154.564,0.6106996896072;
            1155.065,0.61147880236944; 1155.564,0.61147880236944; 1156.062,
            0.61381614065616; 1156.564,0.61277732363984; 1157.065,
            0.61225791513168; 1157.563,0.61043998535312; 1158.063,
            0.61225791513168; 1158.563,0.61251761938576; 1159.063,
            0.61537436618064; 1159.564,0.61147880236944; 1160.063,
            0.61018028109904; 1160.564,0.6119982108776; 1161.065,
            0.61277732363984; 1161.564,0.61121909811536; 1162.062,
            0.61095939386128; 1162.564,0.61303702789392; 1163.063,
            0.61407584491024; 1163.563,0.6106996896072; 1164.063,
            0.61147880236944; 1164.564,0.6094011683368; 1165.063,
            0.60784294281232; 1165.562,0.60836235132048; 1166.064,
            0.60732353430416; 1166.56,0.6094011683368; 1167.064,
            0.60914146408272; 1167.56,0.61485495767248; 1168.064,
            0.6171922959592; 1168.563,0.61615347894288; 1169.065,
            0.61563407043472; 1169.563,0.61667288745104; 1170.062,
            0.61433554916432; 1170.563,0.6158937746888; 1171.063,
            0.61537436618064; 1171.563,0.61355643640208; 1172.062,
            0.61173850662352; 1172.563,0.61381614065616; 1173.064,
            0.61355643640208; 1173.564,0.61173850662352; 1174.061,
            0.60992057684496; 1174.564,0.61121909811536; 1175.065,
            0.61121909811536; 1175.563,0.61147880236944; 1176.065,
            0.61641318319696; 1176.564,0.61277732363984; 1177.064,
            0.61693259170512; 1177.563,0.61511466192656; 1178.063,
            0.61433554916432; 1178.562,0.61537436618064; 1179.064,
            0.61537436618064; 1179.563,0.61563407043472; 1180.063,
            0.61667288745104; 1180.564,0.61381614065616; 1181.065,
            0.6119982108776; 1181.563,0.60836235132048; 1182.064,
            0.6094011683368; 1182.563,0.6119982108776; 1183.064,
            0.61277732363984; 1183.563,0.6106996896072; 1184.06,
            0.61121909811536; 1184.562,0.61018028109904; 1185.063,
            0.6119982108776; 1185.561,0.613296732148; 1186.062,0.61277732363984;
            1186.561,0.61121909811536; 1187.064,0.61043998535312; 1187.563,
            0.61641318319696; 1188.063,0.61407584491024; 1188.563,
            0.6158937746888; 1189.064,0.61823111297552; 1189.563,
            0.6171922959592; 1190.064,0.61693259170512; 1190.564,
            0.61641318319696; 1191.063,0.61926992999184; 1191.563,
            0.61433554916432; 1192.064,0.61901022573776; 1192.563,
            0.61667288745104; 1193.065,0.61901022573776; 1193.564,
            0.61823111297552; 1194.063,0.61875052148368; 1194.564,
            0.61511466192656; 1195.063,0.613296732148; 1195.562,0.6119982108776;
            1196.064,0.61433554916432; 1196.564,0.61407584491024; 1197.063,
            0.613296732148; 1197.564,0.61121909811536; 1198.064,
            0.61355643640208; 1198.563,0.6094011683368; 1199.065,
            0.60706383005008; 1199.563,0.60966087259088; 1200.064,
            0.606804125796; 1200.562,0.60836235132048; 1201.064,
            0.60602501303376; 1201.564,0.60628471728784; 1202.063,
            0.6055056045256; 1202.562,0.60576530877968; 1203.063,
            0.60472649176336; 1203.563,0.6055056045256; 1204.062,
            0.60602501303376; 1204.565,0.60784294281232; 1205.064,
            0.61173850662352; 1205.564,0.61095939386128; 1206.063,
            0.61303702789392; 1206.563,0.61303702789392; 1207.063,
            0.61147880236944; 1207.563,0.61147880236944; 1208.064,
            0.61381614065616; 1208.563,0.613296732148; 1209.061,
            0.61095939386128; 1209.564,0.61043998535312; 1210.062,
            0.6119982108776; 1210.56,0.61095939386128; 1211.062,
            0.61018028109904; 1211.562,0.61173850662352; 1212.062,
            0.60732353430416; 1212.564,0.60784294281232; 1213.062,
            0.60836235132048; 1213.564,0.6081026470664; 1214.064,
            0.60862205557456; 1214.56,0.61018028109904; 1215.064,
            0.6119982108776; 1215.562,0.6106996896072; 1216.061,
            0.61043998535312; 1216.564,0.61381614065616; 1217.065,
            0.60888175982864; 1217.564,0.61277732363984; 1218.063,
            0.60966087259088; 1218.564,0.6119982108776; 1219.063,
            0.61225791513168; 1219.563,0.61433554916432; 1220.063,
            0.6158937746888; 1220.564,0.61667288745104; 1221.063,
            0.61355643640208; 1221.562,0.6171922959592; 1222.063,
            0.61355643640208; 1222.562,0.61771170446736; 1223.065,
            0.61875052148368; 1223.562,0.61303702789392; 1224.064,
            0.61018028109904; 1224.564,0.60992057684496; 1225.064,
            0.61043998535312; 1225.564,0.60966087259088; 1226.064,
            0.61121909811536; 1226.562,0.61147880236944; 1227.062,
            0.60992057684496; 1227.564,0.60914146408272; 1228.063,
            0.61277732363984; 1228.561,0.61147880236944; 1229.064,
            0.61303702789392; 1229.565,0.61303702789392; 1230.064,
            0.61303702789392; 1230.564,0.61277732363984; 1231.064,
            0.61615347894288; 1231.564,0.613296732148; 1232.063,0.6171922959592;
            1232.564,0.61511466192656; 1233.064,0.61563407043472; 1233.562,
            0.61121909811536; 1234.062,0.61043998535312; 1234.566,
            0.60992057684496; 1235.065,0.60914146408272; 1235.564,
            0.60758323855824; 1236.065,0.6042070832552; 1236.563,
            0.60992057684496; 1237.064,0.60966087259088; 1237.564,
            0.61121909811536; 1238.063,0.61511466192656; 1238.563,
            0.6158937746888; 1239.064,0.61823111297552; 1239.562,
            0.61693259170512; 1240.064,0.61615347894288; 1240.564,
            0.61433554916432; 1241.064,0.61693259170512; 1241.564,
            0.61511466192656; 1242.063,0.61381614065616; 1242.561,
            0.61251761938576; 1243.063,0.6145952534184; 1243.564,
            0.61225791513168; 1244.063,0.613296732148; 1244.565,
            0.61511466192656; 1245.064,0.61797140872144; 1245.563,
            0.6184908172296; 1246.064,0.62082815551632; 1246.563,
            0.6184908172296; 1247.062,0.62056845126224; 1247.564,
            0.61641318319696; 1248.065,0.61537436618064; 1248.56,
            0.61926992999184; 1249.065,0.61537436618064; 1249.563,
            0.61563407043472; 1250.065,0.6119982108776; 1250.565,
            0.6171922959592; 1251.062,0.61407584491024; 1251.564,
            0.61615347894288; 1252.065,0.61381614065616; 1252.562,
            0.61407584491024; 1253.064,0.61225791513168; 1253.563,
            0.61303702789392; 1254.064,0.60966087259088; 1254.563,
            0.61173850662352; 1255.065,0.6145952534184; 1255.564,
            0.6158937746888; 1256.064,0.61147880236944; 1256.563,
            0.61433554916432; 1257.063,0.61433554916432; 1257.564,
            0.61277732363984; 1258.064,0.61303702789392; 1258.562,
            0.61511466192656; 1259.062,0.61303702789392; 1259.566,
            0.61303702789392; 1260.064,0.61225791513168; 1260.562,
            0.60992057684496; 1261.063,0.61121909811536; 1261.564,
            0.60654442154192; 1262.063,0.60862205557456; 1262.563,
            0.60758323855824; 1263.063,0.606804125796; 1263.562,
            0.60758323855824; 1264.059,0.6106996896072; 1264.561,
            0.61147880236944; 1265.064,0.61147880236944; 1265.564,
            0.61018028109904; 1266.063,0.61355643640208; 1266.564,
            0.60836235132048; 1267.063,0.6094011683368; 1267.564,
            0.61018028109904; 1268.063,0.61277732363984; 1268.561,
            0.61407584491024; 1269.063,0.61303702789392; 1269.564,
            0.6158937746888; 1270.065,0.61095939386128; 1270.563,
            0.61537436618064; 1271.064,0.61433554916432; 1271.563,
            0.6158937746888; 1272.063,0.61875052148368; 1272.563,
            0.61693259170512; 1273.064,0.61511466192656; 1273.561,
            0.61771170446736; 1274.063,0.61745200021328; 1274.562,
            0.6145952534184; 1275.063,0.61615347894288; 1275.56,
            0.61433554916432; 1276.064,0.6171922959592; 1276.563,
            0.61511466192656; 1277.063,0.61225791513168; 1277.564,
            0.61147880236944; 1278.064,0.61147880236944; 1278.561,
            0.61121909811536; 1279.063,0.61147880236944; 1279.564,
            0.61173850662352; 1280.063,0.61173850662352; 1280.565,
            0.61277732363984; 1281.064,0.61433554916432; 1281.563,
            0.61407584491024; 1282.063,0.613296732148; 1282.562,
            0.61095939386128; 1283.061,0.61251761938576; 1283.561,
            0.61277732363984; 1284.064,0.61485495767248; 1284.562,
            0.61355643640208; 1285.064,0.61407584491024; 1285.563,
            0.613296732148; 1286.065,0.61485495767248; 1286.564,
            0.61381614065616; 1287.064,0.61615347894288; 1287.564,
            0.61018028109904; 1288.063,0.61511466192656; 1288.561,
            0.61615347894288; 1289.063,0.61018028109904; 1289.564,
            0.61433554916432; 1290.064,0.61251761938576; 1290.563,
            0.61407584491024; 1291.064,0.61537436618064; 1291.565,
            0.61433554916432; 1292.064,0.61147880236944; 1292.564,
            0.61147880236944; 1293.064,0.61433554916432; 1293.562,
            0.61251761938576; 1294.061,0.61485495767248; 1294.562,
            0.61745200021328; 1295.065,0.6171922959592; 1295.563,
            0.61615347894288; 1296.061,0.61277732363984; 1296.564,
            0.61095939386128; 1297.064,0.61485495767248; 1297.563,
            0.61381614065616; 1298.064,0.61563407043472; 1298.565,
            0.61485495767248; 1299.064,0.61641318319696; 1299.565,
            0.61277732363984; 1300.061,0.6145952534184; 1300.564,
            0.60992057684496; 1301.064,0.60888175982864; 1301.563,
            0.60862205557456; 1302.064,0.60654442154192; 1302.564,
            0.60576530877968; 1303.063,0.6094011683368; 1303.564,
            0.6106996896072; 1304.064,0.61303702789392; 1304.564,
            0.6119982108776; 1305.063,0.61407584491024; 1305.564,
            0.61303702789392; 1306.065,0.6119982108776; 1306.564,
            0.61303702789392; 1307.064,0.61485495767248; 1307.563,
            0.61537436618064; 1308.063,0.61641318319696; 1308.563,
            0.61381614065616; 1309.065,0.6145952534184; 1309.563,
            0.61121909811536; 1310.065,0.61095939386128; 1310.563,
            0.61355643640208; 1311.066,0.60862205557456; 1311.564,
            0.61225791513168; 1312.065,0.613296732148; 1312.562,
            0.61355643640208; 1313.064,0.61667288745104; 1313.56,
            0.6158937746888; 1314.065,0.61537436618064; 1314.565,
            0.61251761938576; 1315.063,0.61173850662352; 1315.564,
            0.60732353430416; 1316.062,0.60914146408272; 1316.564,
            0.6119982108776; 1317.061,0.613296732148; 1317.563,0.61407584491024;
            1318.064,0.61173850662352; 1318.563,0.61355643640208; 1319.063,
            0.61641318319696; 1319.563,0.61641318319696; 1320.063,
            0.61511466192656; 1320.562,0.61511466192656; 1321.064,
            0.61381614065616; 1321.565,0.61303702789392; 1322.063,
            0.6158937746888; 1322.561,0.6145952534184; 1323.063,
            0.61433554916432; 1323.563,0.61563407043472; 1324.064,
            0.61147880236944; 1324.561,0.6094011683368; 1325.063,
            0.60498619601744; 1325.565,0.60862205557456; 1326.062,
            0.61251761938576; 1326.564,0.61147880236944; 1327.07,
            0.61277732363984; 1327.564,0.61381614065616; 1328.064,
            0.61485495767248; 1328.564,0.6145952534184; 1329.062,
            0.61667288745104; 1329.565,0.61563407043472; 1330.063,
            0.61926992999184; 1330.563,0.6171922959592; 1331.063,
            0.61823111297552; 1331.566,0.61693259170512; 1332.063,
            0.6158937746888; 1332.561,0.6171922959592; 1333.062,
            0.62004904275408; 1333.563,0.62056845126224; 1334.064,
            0.61926992999184; 1334.564,0.61641318319696; 1335.063,
            0.61745200021328; 1335.564,0.61745200021328; 1336.063,
            0.61797140872144; 1336.564,0.61926992999184; 1337.063,
            0.61823111297552; 1337.564,0.62030874700816; 1338.064,
            0.6184908172296; 1338.564,0.61693259170512; 1339.063,
            0.61381614065616; 1339.563,0.61147880236944; 1340.064,
            0.61355643640208; 1340.563,0.61173850662352; 1341.064,
            0.61355643640208; 1341.563,0.61277732363984; 1342.064,
            0.61303702789392; 1342.562,0.61147880236944; 1343.064,
            0.61537436618064; 1343.563,0.61745200021328; 1344.064,
            0.6184908172296; 1344.563,0.61563407043472; 1345.064,
            0.62030874700816; 1345.564,0.6158937746888; 1346.063,
            0.61952963424592; 1346.564,0.61901022573776; 1347.062,
            0.61797140872144; 1347.565,0.61355643640208; 1348.064,
            0.61511466192656; 1348.564,0.61745200021328; 1349.061,
            0.61797140872144; 1349.566,0.61693259170512; 1350.064,
            0.61615347894288; 1350.566,0.6158937746888; 1351.064,
            0.61615347894288; 1351.563,0.61511466192656; 1352.064,
            0.61147880236944; 1352.564,0.6119982108776; 1353.064,
            0.60992057684496; 1353.565,0.60888175982864; 1354.062,
            0.6094011683368; 1354.564,0.61173850662352; 1355.064,
            0.6119982108776; 1355.564,0.61018028109904; 1356.064,
            0.61173850662352; 1356.564,0.6119982108776; 1357.064,
            0.61018028109904; 1357.564,0.61251761938576; 1358.064,
            0.6145952534184; 1358.565,0.61121909811536; 1359.065,
            0.61433554916432; 1359.565,0.61563407043472; 1360.065,
            0.61537436618064; 1360.565,0.61355643640208; 1361.064,
            0.61693259170512; 1361.564,0.61511466192656; 1362.063,
            0.613296732148; 1362.564,0.6106996896072; 1363.065,0.6119982108776;
            1363.561,0.61225791513168; 1364.064,0.61173850662352; 1364.563,
            0.61173850662352; 1365.063,0.61381614065616; 1365.564,
            0.61173850662352; 1366.065,0.61173850662352; 1366.564,
            0.613296732148; 1367.064,0.61511466192656; 1367.563,
            0.61121909811536; 1368.065,0.61381614065616; 1368.562,
            0.60888175982864; 1369.065,0.60862205557456; 1369.565,
            0.6106996896072; 1370.064,0.61095939386128; 1370.564,
            0.61277732363984; 1371.064,0.61407584491024; 1371.564,
            0.6119982108776; 1372.063,0.61173850662352; 1372.563,
            0.61225791513168; 1373.064,0.61407584491024; 1373.564,
            0.61563407043472; 1374.064,0.6145952534184; 1374.564,
            0.61745200021328; 1375.065,0.61407584491024; 1375.564,
            0.61537436618064; 1376.063,0.61147880236944; 1376.565,
            0.60394737900112; 1377.064,0.56343351536464; 1377.564,
            0.50266271990992; 1378.064,0.44552778401232; 1378.564,
            0.39930042678608; 1379.064,0.35567011210064; 1379.564,
            0.3224279675784; 1380.065,0.2951590209; 1380.565,0.26607214444304;
            1381.064,0.25074959345232; 1381.564,0.22919414036368; 1382.065,
            0.21542981489744; 1382.561,0.20478194048016; 1383.064,
            0.1938743618088; 1383.563,0.18712205120272; 1384.063,
            0.1769935852936; 1384.565,0.17102038744976; 1385.065,
            0.16868304916304; 1385.564,0.16193073855696; 1386.064,
            0.15777547049168; 1386.565,0.15725606198352; 1387.064,
            0.15206197690192; 1387.564,0.1471275960744; 1388.064,
            0.14401114502544; 1388.564,0.14089469397648; 1389.063,
            0.1419335109928; 1389.564,0.13881705994384; 1390.066,
            0.13596031314896; 1390.564,0.13751853867344; 1391.065,
            0.1354409046408; 1391.564,0.13699913016528; 1392.064,
            0.1354409046408; 1392.563,0.13622001740304; 1393.063,
            0.13907676419792; 1393.564,0.13881705994384; 1394.064,
            0.14011558121424; 1394.565,0.1406349897224; 1395.063,
            0.14167380673872; 1395.564,0.14504996204176; 1396.065,
            0.14504996204176; 1396.565,0.1432320322632; 1397.063,
            0.14634848331216; 1397.563,0.1484261173448; 1398.063,
            0.15154256839376; 1398.564,0.15439931518864; 1399.063,
            0.15258138541008; 1399.567,0.15673665347536; 1400.063,
            0.1575157662376; 1400.563,0.15933369601616; 1401.064,
            0.16426807684368; 1401.564,0.16245014706512; 1402.064,
            0.16712482363856; 1402.564,0.16608600662224; 1403.064,
            0.16868304916304; 1403.565,0.17283831722832; 1404.063,
            0.17283831722832; 1404.565,0.17517565551504; 1405.065,
            0.17465624700688; 1405.563,0.17751299380176; 1406.064,
            0.17907121932624; 1406.565,0.18244737462928; 1407.065,
            0.18322648739152; 1407.564,0.18296678313744; 1408.064,
            0.18686234694864; 1408.564,0.18582352993232; 1409.064,
            0.1873817554568; 1409.561,0.18790116396496; 1410.064,
            0.18971909374352; 1410.563,0.19179672777616; 1411.065,
            0.19283554479248; 1411.564,0.19335495330064; 1412.066,
            0.19932815114448; 1412.561,0.20114608092304; 1413.064,
            0.20270430644752; 1413.565,0.20711927876688; 1414.062,
            0.20997602556176; 1414.564,0.2094566170536; 1415.064,
            0.21127454683216; 1415.563,0.21361188511888; 1416.063,
            0.2159492234056; 1416.564,0.21439099788112; 1417.063,
            0.21672833616784; 1417.563,0.21750744893008; 1418.063,
            0.2198447872168; 1418.563,0.22270153401168; 1419.063,
            0.22348064677392; 1419.564,0.22555828080656; 1420.065,
            0.22218212550352; 1420.563,0.22270153401168; 1421.065,
            0.22270153401168; 1421.563,0.2250388722984; 1422.064,
            0.2276359148392; 1422.564,0.23023295738; 1423.065,0.2341285211912;
            1423.561,0.22919414036368; 1424.065,0.23308970417488; 1424.565,
            0.23231059141264; 1425.061,0.23308970417488; 1425.565,
            0.23334940842896; 1426.064,0.23257029566672; 1426.563,
            0.23179118290448; 1427.064,0.23101207014224; 1427.563,
            0.23049266163408; 1428.062,0.2328299999208; 1428.565,
            0.22997325312592; 1429.063,0.23205088715856; 1429.561,
            0.22815532334736; 1430.062,0.23049266163408; 1430.565,
            0.23101207014224; 1431.062,0.23101207014224; 1431.561,
            0.22815532334736; 1432.063,0.22789561909328; 1432.564,0.23023295738;
            1433.064,0.23049266163408; 1433.562,0.23257029566672; 1434.062,
            0.23594645096976; 1434.56,0.22841502760144; 1435.063,
            0.22867473185552; 1435.564,0.2263373935688; 1436.064,0.223740351028;
            1436.562,0.22140301274128; 1437.064,0.22218212550352; 1437.564,
            0.22192242124944; 1438.064,0.21776715318416; 1438.563,
            0.21672833616784; 1439.063,0.21517011064336; 1439.565,
            0.21750744893008; 1440.065,0.21776715318416; 1440.564,
            0.21153425108624; 1441.064,0.20893720854544; 1441.564,
            0.2081580957832; 1442.065,0.2068595745128; 1442.563,
            0.21049543406992; 1443.064,0.20582075749648; 1443.565,
            0.20504164473424; 1444.064,0.204262531972; 1444.564,
            0.20789839152912; 1445.065,0.210755138324; 1445.565,
            0.20789839152912; 1446.062,0.20478194048016; 1446.563,
            0.20711927876688; 1447.065,0.20400282771792; 1447.564,
            0.19751022136592; 1448.065,0.20062667241488; 1448.564,
            0.19283554479248; 1449.064,0.1951728830792; 1449.564,
            0.19023850225168; 1450.063,0.19361465755472; 1450.561,
            0.19049820650576; 1451.064,0.18712205120272; 1451.565,
            0.18816086821904; 1452.064,0.18296678313744; 1452.564,
            0.1808891491048; 1453.065,0.1821876703752; 1453.563,
            0.18140855761296; 1454.065,0.1821876703752; 1454.566,
            0.17907121932624; 1455.065,0.18114885335888; 1455.562,
            0.17855181081808; 1456.064,0.18114885335888; 1456.563,
            0.17751299380176; 1457.064,0.17673388103952; 1457.564,
            0.17751299380176; 1458.064,0.17725328954768; 1458.564,
            0.1769935852936; 1459.064,0.17335772573648; 1459.564,
            0.17673388103952; 1460.064,0.17465624700688; 1460.562,
            0.17335772573648; 1461.065,0.17283831722832; 1461.565,
            0.1705009789416; 1462.064,0.17024127468752; 1462.563,
            0.17102038744976; 1463.062,0.16972186617936; 1463.565,
            0.16972186617936; 1464.063,0.16998157043344; 1464.564,
            0.17257861297424; 1465.066,0.17335772573648; 1465.563,
            0.17128009170384; 1466.064,0.171799500212; 1466.563,
            0.17205920446608; 1467.063,0.1730980214824; 1467.564,
            0.16894275341712; 1468.062,0.17361742999056; 1468.564,
            0.1705009789416; 1469.065,0.17231890872016; 1469.561,
            0.16868304916304; 1470.063,0.16998157043344; 1470.565,
            0.16764423214672; 1471.065,0.16972186617936; 1471.564,
            0.16972186617936; 1472.063,0.16738452789264; 1472.565,
            0.16764423214672; 1473.061,0.16634571087632; 1473.564,
            0.16452778109776; 1474.062,0.16764423214672; 1474.564,
            0.16634571087632; 1475.064,0.16322925982736; 1475.564,
            0.1679039364008; 1476.064,0.16374866833552; 1476.565,0.16530689386;
            1477.063,0.1666054151304; 1477.565,0.16530689386; 1478.065,
            0.16452778109776; 1478.565,0.1601128087784; 1479.062,
            0.15985310452432; 1479.56,0.15855458325392; 1480.062,
            0.16063221728656; 1480.564,0.16530689386; 1481.064,0.15855458325392;
            1481.563,0.16115162579472; 1482.065,0.16167103430288; 1482.564,
            0.16089192154064; 1483.064,0.16712482363856; 1483.563,
            0.16167103430288; 1484.062,0.15855458325392; 1484.566,
            0.16167103430288; 1485.064,0.158814287508; 1485.565,
            0.15543813220496; 1486.063,0.15985310452432; 1486.563,
            0.15569783645904; 1487.062,0.15933369601616; 1487.565,
            0.16193073855696; 1488.065,0.16063221728656; 1488.564,
            0.1627098513192; 1489.064,0.16037251303248; 1489.564,
            0.15985310452432; 1490.062,0.1614113300488; 1490.566,
            0.16063221728656; 1491.064,0.16037251303248; 1491.56,
            0.16245014706512; 1492.064,0.16348896408144; 1492.562,
            0.1614113300488; 1493.066,0.16452778109776; 1493.566,
            0.16322925982736; 1494.063,0.16478748535184; 1494.564,
            0.16167103430288; 1495.063,0.16868304916304; 1495.565,
            0.16686511938448; 1496.062,0.16712482363856; 1496.565,
            0.16426807684368; 1497.062,0.16946216192528; 1497.564,
            0.1679039364008; 1498.064,0.16738452789264; 1498.563,
            0.16842334490896; 1499.061,0.17024127468752; 1499.564,
            0.17128009170384; 1500.063,0.16868304916304; 1500.565,
            0.17387713424464; 1501.064,0.16998157043344; 1501.563,
            0.1743965427528; 1502.063,0.17517565551504; 1502.561,
            0.1769935852936; 1503.064,0.17647417678544; 1503.565,
            0.17361742999056; 1504.062,0.17595476827728; 1504.563,
            0.17855181081808; 1505.064,0.1756950640232; 1505.564,
            0.1795906278344; 1506.064,0.17725328954768; 1506.564,
            0.18270707888336; 1507.064,0.17907121932624; 1507.564,
            0.18011003634256; 1508.064,0.17855181081808; 1508.564,
            0.1808891491048; 1509.061,0.18244737462928; 1509.564,
            0.18166826186704; 1510.063,0.1821876703752; 1510.564,
            0.18244737462928; 1511.065,0.18296678313744; 1511.562,
            0.18114885335888; 1512.065,0.18270707888336; 1512.563,
            0.1834861916456; 1513.063,0.18270707888336; 1513.563,
            0.18452500866192; 1514.061,0.18504441717008; 1514.564,
            0.18166826186704; 1515.064,0.18400560015376; 1515.564,
            0.18556382567824; 1516.065,0.19049820650576; 1516.564,
            0.191277319268; 1517.065,0.1886802767272; 1517.566,0.1834861916456;
            1518.065,0.18712205120272; 1518.564,0.18893998098128; 1519.062,
            0.18790116396496; 1519.563,0.19101761501392; 1520.063,
            0.18893998098128; 1520.565,0.19179672777616; 1521.066,
            0.18971909374352; 1521.564,0.19049820650576; 1522.065,
            0.19335495330064; 1522.563,0.19049820650576; 1523.062,
            0.19231613628432; 1523.563,0.19231613628432; 1524.062,
            0.19205643203024; 1524.563,0.19361465755472; 1525.064,
            0.19465347457104; 1525.565,0.19491317882512; 1526.065,
            0.19465347457104; 1526.563,0.19413406606288; 1527.063,
            0.1938743618088; 1527.563,0.19465347457104; 1528.062,
            0.19491317882512; 1528.562,0.1925758405384; 1529.06,
            0.19595199584144; 1529.565,0.19439377031696; 1530.064,
            0.19699081285776; 1530.564,0.19595199584144; 1531.064,
            0.19231613628432; 1531.564,0.19828933412816; 1532.064,
            0.19595199584144; 1532.562,0.19958785539856; 1533.063,
            0.19595199584144; 1533.565,0.19621170009552; 1534.061,
            0.19335495330064; 1534.563,0.19699081285776; 1535.064,
            0.19335495330064; 1535.565,0.1964714043496; 1536.064,
            0.19335495330064; 1536.564,0.1951728830792; 1537.062,
            0.19413406606288; 1537.564,0.19309524904656; 1538.063,
            0.19465347457104; 1538.565,0.19543258733328; 1539.061,
            0.19335495330064; 1539.566,0.19491317882512; 1540.063,
            0.19023850225168; 1540.566,0.19361465755472; 1541.062,
            0.19075791075984; 1541.563,0.19283554479248; 1542.063,
            0.19413406606288; 1542.563,0.19491317882512; 1543.063,
            0.19335495330064; 1543.565,0.1925758405384; 1544.062,
            0.19309524904656; 1544.563,0.19075791075984; 1545.062,
            0.19179672777616; 1545.563,0.19179672777616; 1546.064,
            0.19023850225168; 1546.564,0.18971909374352; 1547.063,
            0.19101761501392; 1547.561,0.19179672777616; 1548.061,
            0.19075791075984; 1548.562,0.18919968523536; 1549.062,
            0.191277319268; 1549.563,0.18945938948944; 1550.062,
            0.18790116396496; 1550.564,0.1899787979976; 1551.064,
            0.18582352993232; 1551.563,0.18764145971088; 1552.063,
            0.18842057247312; 1552.565,0.18893998098128; 1553.062,
            0.18452500866192; 1553.56,0.18660264269456; 1554.062,
            0.18426530440784; 1554.562,0.18426530440784; 1555.062,
            0.18244737462928; 1555.565,0.18374589589968; 1556.062,
            0.18400560015376; 1556.561,0.18270707888336; 1557.062,
            0.1834861916456; 1557.565,0.18166826186704; 1558.063,
            0.1834861916456; 1558.563,0.18114885335888; 1559.061,0.184784712916;
            1559.563,0.18166826186704; 1560.064,0.18270707888336; 1560.564,
            0.18140855761296; 1561.062,0.18582352993232; 1561.564,
            0.18426530440784; 1562.064,0.18712205120272; 1562.562,
            0.18530412142416; 1563.065,0.18556382567824; 1563.562,
            0.1834861916456; 1564.064,0.1860832341864; 1564.564,
            0.18322648739152; 1565.065,0.18504441717008; 1565.563,
            0.184784712916; 1566.062,0.1860832341864; 1566.564,0.184784712916;
            1567.062,0.184784712916; 1567.564,0.18452500866192; 1568.063,
            0.18270707888336; 1568.561,0.18634293844048; 1569.065,
            0.1834861916456; 1569.563,0.1860832341864; 1570.064,
            0.18270707888336; 1570.563,0.1834861916456; 1571.063,
            0.1834861916456; 1571.563,0.184784712916; 1572.061,0.18452500866192;
            1572.564,0.18452500866192; 1573.065,0.18400560015376; 1573.564,
            0.1873817554568; 1574.062,0.18374589589968; 1574.563,
            0.18582352993232; 1575.061,0.18374589589968; 1575.561,
            0.1834861916456; 1576.062,0.184784712916; 1576.563,0.18426530440784;
            1577.064,0.18686234694864; 1577.564,0.18296678313744; 1578.064,
            0.18790116396496; 1578.564,0.184784712916; 1579.062,0.1899787979976;
            1579.563,0.18686234694864; 1580.064,0.18504441717008; 1580.564,
            0.19023850225168; 1581.064,0.19075791075984; 1581.564,
            0.18971909374352; 1582.062,0.18556382567824; 1582.564,
            0.18712205120272; 1583.063,0.18764145971088; 1583.562,
            0.18504441717008; 1584.064,0.18764145971088; 1584.564,
            0.1886802767272; 1585.065,0.18945938948944; 1585.563,
            0.18556382567824; 1586.064,0.19335495330064; 1586.564,
            0.18945938948944; 1587.065,0.18660264269456; 1587.564,
            0.19179672777616; 1588.063,0.18712205120272; 1588.564,
            0.18764145971088; 1589.063,0.18452500866192; 1589.564,
            0.18452500866192; 1590.063,0.184784712916; 1590.565,
            0.18296678313744; 1591.065,0.18452500866192; 1591.566,
            0.18322648739152; 1592.065,0.18400560015376; 1592.563,
            0.18530412142416; 1593.063,0.18556382567824; 1593.565,
            0.18686234694864; 1594.062,0.18556382567824; 1594.566,
            0.18764145971088; 1595.063,0.18660264269456; 1595.563,
            0.18971909374352; 1596.065,0.18686234694864; 1596.563,
            0.18945938948944; 1597.061,0.18660264269456; 1597.565,
            0.1886802767272; 1598.064,0.19075791075984; 1598.566,
            0.18816086821904; 1599.061,0.18634293844048; 1599.564,
            0.18816086821904; 1600.064,0.18919968523536; 1600.564,
            0.191277319268; 1601.065,0.18712205120272; 1601.564,0.1886802767272;
            1602.065,0.18556382567824; 1602.564,0.18712205120272; 1603.063,
            0.18556382567824; 1603.564,0.18322648739152; 1604.062,
            0.18634293844048; 1604.564,0.18582352993232; 1605.065,
            0.18452500866192; 1605.564,0.18270707888336; 1606.066,
            0.18400560015376; 1606.566,0.18140855761296; 1607.064,
            0.1886802767272; 1607.565,0.18842057247312; 1608.065,
            0.18686234694864; 1608.562,0.1873817554568; 1609.065,
            0.18660264269456; 1609.563,0.1860832341864; 1610.063,
            0.18919968523536; 1610.564,0.18945938948944; 1611.065,
            0.18764145971088; 1611.565,0.18893998098128; 1612.063,
            0.19153702352208; 1612.565,0.18816086821904; 1613.061,
            0.19283554479248; 1613.565,0.1873817554568; 1614.064,
            0.18971909374352; 1614.564,0.18660264269456; 1615.064,
            0.18634293844048; 1615.564,0.18971909374352; 1616.063,
            0.18712205120272; 1616.563,0.18790116396496; 1617.061,
            0.19023850225168; 1617.563,0.1886802767272; 1618.063,
            0.19023850225168; 1618.562,0.18919968523536; 1619.063,
            0.1886802767272; 1619.565,0.18919968523536; 1620.065,
            0.1886802767272; 1620.565,0.18764145971088; 1621.061,
            0.18893998098128; 1621.562,0.1925758405384; 1622.065,
            0.19049820650576; 1622.563,0.19309524904656; 1623.062,
            0.19465347457104; 1623.564,0.1925758405384; 1624.064,
            0.19543258733328; 1624.561,0.19101761501392; 1625.063,
            0.19309524904656; 1625.564,0.19075791075984; 1626.065,
            0.19153702352208; 1626.564,0.1925758405384; 1627.062,
            0.19205643203024; 1627.564,0.1925758405384; 1628.062,
            0.1925758405384; 1628.565,0.19543258733328; 1629.064,
            0.19725051711184; 1629.565,0.19673110860368; 1630.063,
            0.19543258733328; 1630.565,0.19439377031696; 1631.061,
            0.19465347457104; 1631.566,0.19621170009552; 1632.065,
            0.19569229158736; 1632.564,0.19595199584144; 1633.064,
            0.19621170009552; 1633.564,0.1964714043496; 1634.064,
            0.19153702352208; 1634.563,0.1925758405384; 1635.064,
            0.19205643203024; 1635.565,0.18971909374352; 1636.064,
            0.19205643203024; 1636.562,0.19101761501392; 1637.065,
            0.18893998098128; 1637.565,0.19023850225168; 1638.061,
            0.18634293844048; 1638.565,0.18919968523536; 1639.065,
            0.18790116396496; 1639.564,0.18426530440784; 1640.066,
            0.18919968523536; 1640.565,0.18556382567824; 1641.064,
            0.18712205120272; 1641.565,0.18893998098128; 1642.064,
            0.18790116396496; 1642.564,0.19101761501392; 1643.062,
            0.1886802767272; 1643.567,0.18893998098128; 1644.064,
            0.18842057247312; 1644.564,0.18790116396496; 1645.065,
            0.18919968523536; 1645.564,0.18945938948944; 1646.065,
            0.1886802767272; 1646.565,0.19023850225168; 1647.064,
            0.19075791075984; 1647.563,0.18971909374352; 1648.065,
            0.18686234694864; 1648.565,0.18686234694864; 1649.064,
            0.18712205120272; 1649.563,0.18919968523536; 1650.063,
            0.18660264269456; 1650.565,0.19413406606288; 1651.065,
            0.19075791075984; 1651.564,0.18842057247312; 1652.066,
            0.18790116396496; 1652.565,0.18842057247312; 1653.064,
            0.18790116396496; 1653.565,0.18712205120272; 1654.061,
            0.19205643203024; 1654.561,0.19283554479248; 1655.062,
            0.19491317882512; 1655.561,0.19595199584144; 1656.061,
            0.1964714043496; 1656.563,0.19621170009552; 1657.062,
            0.19802962987408; 1657.564,0.19673110860368; 1658.065,
            0.1964714043496; 1658.566,0.19465347457104; 1659.065,
            0.19543258733328; 1659.562,0.19101761501392; 1660.062,
            0.19283554479248; 1660.563,0.19179672777616; 1661.061,
            0.1899787979976; 1661.564,0.19075791075984; 1662.064,
            0.19205643203024; 1662.566,0.19231613628432; 1663.063,
            0.1938743618088; 1663.563,0.19465347457104; 1664.064,
            0.19023850225168; 1664.561,0.19231613628432; 1665.065,
            0.19023850225168; 1665.564,0.1899787979976; 1666.064,
            0.19075791075984; 1666.563,0.18919968523536; 1667.065,
            0.19101761501392; 1667.565,0.19231613628432; 1668.065,
            0.19153702352208; 1668.562,0.19231613628432; 1669.062,
            0.1899787979976; 1669.563,0.19361465755472; 1670.066,0.191277319268;
            1670.564,0.18893998098128; 1671.063,0.19569229158736; 1671.565,
            0.1925758405384; 1672.064,0.18919968523536; 1672.565,
            0.19231613628432; 1673.063,0.1938743618088; 1673.561,
            0.19309524904656; 1674.063,0.19595199584144; 1674.563,
            0.1938743618088; 1675.063,0.191277319268; 1675.564,0.19023850225168;
            1676.065,0.18945938948944; 1676.565,0.191277319268; 1677.063,
            0.19205643203024; 1677.563,0.19543258733328; 1678.064,
            0.19569229158736; 1678.564,0.19491317882512; 1679.066,
            0.19413406606288; 1679.563,0.19361465755472; 1680.064,
            0.19205643203024; 1680.56,0.19699081285776; 1681.063,
            0.19569229158736; 1681.561,0.19205643203024; 1682.062,
            0.19361465755472; 1682.565,0.19543258733328; 1683.062,
            0.19673110860368; 1683.564,0.1951728830792; 1684.065,
            0.19595199584144; 1684.564,0.19335495330064; 1685.065,
            0.191277319268; 1685.565,0.19023850225168; 1686.065,0.1925758405384;
            1686.563,0.18893998098128; 1687.065,0.18945938948944; 1687.564,
            0.18686234694864; 1688.064,0.18686234694864; 1688.564,
            0.1873817554568; 1689.065,0.18530412142416; 1689.565,
            0.18842057247312; 1690.064,0.18400560015376; 1690.564,
            0.184784712916; 1691.065,0.1873817554568; 1691.564,0.18660264269456;
            1692.067,0.18530412142416; 1692.565,0.18452500866192; 1693.062,
            0.18764145971088; 1693.565,0.18842057247312; 1694.06,
            0.18530412142416; 1694.565,0.18660264269456; 1695.065,
            0.18374589589968; 1695.562,0.18764145971088; 1696.064,
            0.18686234694864; 1696.566,0.1873817554568; 1697.064,
            0.18790116396496; 1697.564,0.18660264269456; 1698.063,
            0.18919968523536; 1698.562,0.18764145971088; 1699.064,
            0.1899787979976; 1699.565,0.18660264269456; 1700.066,
            0.18945938948944; 1700.562,0.191277319268; 1701.063,
            0.18842057247312; 1701.564,0.19075791075984; 1702.064,
            0.18919968523536; 1702.561,0.191277319268; 1703.066,
            0.19205643203024; 1703.565,0.19179672777616; 1704.065,
            0.1951728830792; 1704.564,0.19309524904656; 1705.063,
            0.19621170009552; 1705.564,0.19491317882512; 1706.062,
            0.19751022136592; 1706.563,0.20114608092304; 1707.063,
            0.20374312346384; 1707.565,0.19854903838224; 1708.065,
            0.19751022136592; 1708.565,0.19725051711184; 1709.065,
            0.19932815114448; 1709.563,0.19595199584144; 1710.061,
            0.19231613628432; 1710.564,0.19465347457104; 1711.064,
            0.19699081285776; 1711.563,0.19725051711184; 1712.063,
            0.19309524904656; 1712.564,0.19543258733328; 1713.063,
            0.1951728830792; 1713.564,0.19439377031696; 1714.064,
            0.19673110860368; 1714.565,0.19621170009552; 1715.064,
            0.19283554479248; 1715.566,0.1964714043496; 1716.066,
            0.19361465755472; 1716.564,0.19101761501392; 1717.061,
            0.19153702352208; 1717.565,0.19153702352208; 1718.062,
            0.19283554479248; 1718.563,0.19205643203024; 1719.064,
            0.1925758405384; 1719.562,0.19231613628432; 1720.065,
            0.19413406606288; 1720.565,0.1925758405384; 1721.065,
            0.1938743618088; 1721.564,0.19491317882512; 1722.065,
            0.19335495330064; 1722.564,0.1964714043496; 1723.065,
            0.19283554479248; 1723.565,0.19309524904656; 1724.065,
            0.19361465755472; 1724.561,0.1925758405384; 1725.064,
            0.1938743618088; 1725.564,0.19439377031696; 1726.065,
            0.19439377031696; 1726.565,0.19465347457104; 1727.064,
            0.19179672777616; 1727.563,0.1938743618088; 1728.064,
            0.19569229158736; 1728.563,0.19361465755472; 1729.065,
            0.19309524904656; 1729.564,0.19491317882512; 1730.064,
            0.1964714043496; 1730.564,0.19491317882512; 1731.064,
            0.19439377031696; 1731.564,0.19569229158736; 1732.066,
            0.19439377031696; 1732.563,0.19673110860368; 1733.064,
            0.19361465755472; 1733.564,0.19283554479248; 1734.062,
            0.19543258733328; 1734.562,0.1964714043496; 1735.063,
            0.19491317882512; 1735.563,0.19569229158736; 1736.063,
            0.19413406606288; 1736.565,0.19673110860368; 1737.064,
            0.19491317882512; 1737.563,0.19361465755472; 1738.063,
            0.19439377031696; 1738.565,0.19309524904656; 1739.064,
            0.19439377031696; 1739.562,0.1938743618088; 1740.065,
            0.19491317882512; 1740.561,0.1951728830792; 1741.066,
            0.19049820650576; 1741.564,0.19595199584144; 1742.064,
            0.19880874263632; 1742.563,0.19932815114448; 1743.062,
            0.19725051711184; 1743.564,0.19309524904656; 1744.063,
            0.19283554479248; 1744.562,0.1951728830792; 1745.063,
            0.1964714043496; 1745.564,0.19283554479248; 1746.065,
            0.19283554479248; 1746.561,0.19439377031696; 1747.062,0.19776992562;
            1747.563,0.19361465755472; 1748.065,0.19621170009552; 1748.564,
            0.19413406606288; 1749.063,0.19439377031696; 1749.562,
            0.19673110860368; 1750.064,0.1964714043496; 1750.564,
            0.19075791075984; 1751.065,0.19465347457104; 1751.566,
            0.19231613628432; 1752.064,0.1938743618088; 1752.565,
            0.19335495330064; 1753.064,0.19361465755472; 1753.565,
            0.19465347457104; 1754.066,0.19231613628432; 1754.562,
            0.19439377031696; 1755.064,0.19205643203024; 1755.563,
            0.19205643203024; 1756.063,0.19153702352208; 1756.565,
            0.19673110860368; 1757.065,0.19205643203024; 1757.565,
            0.19491317882512; 1758.064,0.1899787979976; 1758.564,
            0.19179672777616; 1759.063,0.19153702352208; 1759.563,
            0.18971909374352; 1760.066,0.19153702352208; 1760.563,
            0.19673110860368; 1761.065,0.19101761501392; 1761.566,
            0.19465347457104; 1762.063,0.19179672777616; 1762.564,
            0.19413406606288; 1763.064,0.19075791075984; 1763.563,
            0.1938743618088; 1764.065,0.19335495330064; 1764.562,
            0.19205643203024; 1765.063,0.191277319268; 1765.565,
            0.19751022136592; 1766.064,0.19179672777616; 1766.563,
            0.19283554479248; 1767.065,0.19153702352208; 1767.564,
            0.19075791075984; 1768.065,0.1925758405384; 1768.564,
            0.19205643203024; 1769.064,0.1938743618088; 1769.562,
            0.19595199584144; 1770.065,0.1951728830792; 1770.562,
            0.19439377031696; 1771.065,0.19569229158736; 1771.563,
            0.19673110860368; 1772.064,0.19984755965264; 1772.563,
            0.19751022136592; 1773.063,0.20270430644752; 1773.564,
            0.20088637666896; 1774.064,0.20010726390672; 1774.561,
            0.20244460219344; 1775.064,0.19958785539856; 1775.56,
            0.20062667241488; 1776.065,0.19751022136592; 1776.564,
            0.19880874263632; 1777.065,0.19621170009552; 1777.564,
            0.19673110860368; 1778.066,0.19673110860368; 1778.564,
            0.19413406606288; 1779.064,0.1938743618088; 1779.563,
            0.1925758405384; 1780.063,0.19413406606288; 1780.563,
            0.19465347457104; 1781.064,0.19491317882512; 1781.564,
            0.19335495330064; 1782.065,0.1938743618088; 1782.563,
            0.19439377031696; 1783.063,0.19283554479248; 1783.563,
            0.1938743618088; 1784.066,0.1951728830792; 1784.562,
            0.19049820650576; 1785.066,0.1925758405384; 1785.564,
            0.18971909374352; 1786.064,0.18971909374352; 1786.563,
            0.18790116396496; 1787.063,0.19023850225168; 1787.564,
            0.19205643203024; 1788.065,0.19101761501392; 1788.564,
            0.1938743618088; 1789.064,0.1925758405384; 1789.564,0.1925758405384;
            1790.065,0.19595199584144; 1790.564,0.1925758405384; 1791.064,
            0.19335495330064; 1791.564,0.19361465755472; 1792.062,
            0.18971909374352; 1792.564,0.19880874263632; 1793.063,
            0.19309524904656; 1793.564,0.19361465755472; 1794.063,
            0.19283554479248; 1794.562,0.18945938948944; 1795.064,
            0.18919968523536; 1795.563,0.19465347457104; 1796.064,
            0.191277319268; 1796.565,0.19231613628432; 1797.064,
            0.19049820650576; 1797.564,0.191277319268; 1798.064,
            0.19465347457104; 1798.564,0.191277319268; 1799.065,0.191277319268;
            1799.566,0.1899787979976; 1800.062,0.18790116396496; 1800.564,
            0.19309524904656; 1801.063,0.19153702352208; 1801.566,
            0.19231613628432; 1802.065,0.19049820650576; 1802.565,
            0.19153702352208; 1803.065,0.18893998098128; 1803.566,
            0.19101761501392; 1804.063,0.1938743618088; 1804.564,
            0.19231613628432; 1805.065,0.19205643203024; 1805.566,
            0.1925758405384; 1806.065,0.19335495330064; 1806.564,
            0.19179672777616; 1807.064,0.1925758405384; 1807.562,
            0.19101761501392; 1808.063,0.1899787979976; 1808.563,
            0.19231613628432; 1809.065,0.19023850225168; 1809.566,
            0.19465347457104; 1810.065,0.19491317882512; 1810.564,
            0.19283554479248; 1811.063,0.19413406606288; 1811.565,
            0.19309524904656; 1812.066,0.1951728830792; 1812.565,
            0.19595199584144; 1813.065,0.19569229158736; 1813.565,
            0.19569229158736; 1814.063,0.19673110860368; 1814.566,
            0.19569229158736; 1815.065,0.1925758405384; 1815.564,
            0.19309524904656; 1816.066,0.19465347457104; 1816.565,
            0.1951728830792; 1817.065,0.19725051711184; 1817.565,
            0.1990684468904; 1818.065,0.19595199584144; 1818.564,
            0.1925758405384; 1819.064,0.19465347457104; 1819.564,
            0.19621170009552; 1820.066,0.19854903838224; 1820.563,
            0.19725051711184; 1821.065,0.19699081285776; 1821.565,
            0.19751022136592; 1822.064,0.1964714043496; 1822.565,
            0.20088637666896; 1823.064,0.19984755965264; 1823.564,0.19776992562;
            1824.064,0.19543258733328; 1824.565,0.1951728830792; 1825.064,
            0.19439377031696; 1825.565,0.19595199584144; 1826.065,
            0.19725051711184; 1826.565,0.19673110860368; 1827.065,
            0.19361465755472; 1827.566,0.1951728830792; 1828.065,
            0.19413406606288; 1828.566,0.1886802767272; 1829.064,
            0.19023850225168; 1829.565,0.19413406606288; 1830.065,
            0.19361465755472; 1830.564,0.19751022136592; 1831.065,
            0.19751022136592; 1831.565,0.1951728830792; 1832.064,
            0.20088637666896; 1832.563,0.19673110860368; 1833.064,0.19776992562;
            1833.564,0.19673110860368; 1834.062,0.19673110860368; 1834.562,
            0.19776992562; 1835.065,0.19543258733328; 1835.563,0.1964714043496;
            1836.065,0.19595199584144; 1836.565,0.19543258733328; 1837.064,
            0.19439377031696; 1837.564,0.19465347457104; 1838.064,
            0.19361465755472; 1838.564,0.19491317882512; 1839.064,
            0.1964714043496; 1839.565,0.19465347457104; 1840.067,
            0.1964714043496; 1840.565,0.19725051711184; 1841.066,
            0.19880874263632; 1841.564,0.19699081285776; 1842.065,
            0.19802962987408; 1842.566,0.19854903838224; 1843.064,
            0.19828933412816; 1843.563,0.19958785539856; 1844.066,
            0.19465347457104; 1844.566,0.19828933412816; 1845.065,
            0.19984755965264; 1845.563,0.2003669681608; 1846.065,
            0.2029640107016; 1846.565,0.20504164473424; 1847.064,
            0.20374312346384; 1847.566,0.20244460219344; 1848.066,
            0.2029640107016; 1848.566,0.20218489793936; 1849.066,
            0.20114608092304; 1849.566,0.20088637666896; 1850.066,
            0.20114608092304; 1850.565,0.1990684468904; 1851.065,
            0.19699081285776; 1851.565,0.19543258733328; 1852.064,0.19776992562;
            1852.564,0.19439377031696; 1853.065,0.19413406606288; 1853.565,
            0.1951728830792; 1854.065,0.19465347457104; 1854.565,
            0.1951728830792; 1855.065,0.19465347457104; 1855.565,
            0.19673110860368; 1856.061,0.19569229158736; 1856.563,0.19776992562;
            1857.064,0.19569229158736; 1857.565,0.19595199584144; 1858.065,
            0.19776992562; 1858.565,0.1951728830792; 1859.066,0.19725051711184;
            1859.564,0.19439377031696; 1860.064,0.19543258733328; 1860.565,
            0.19335495330064; 1861.064,0.19361465755472; 1861.565,
            0.19595199584144; 1862.064,0.1938743618088; 1862.565,
            0.19335495330064; 1863.062,0.19699081285776; 1863.565,
            0.1964714043496; 1864.061,0.19309524904656; 1864.563,
            0.1964714043496; 1865.063,0.19543258733328; 1865.563,
            0.19361465755472; 1866.062,0.19439377031696; 1866.566,0.19776992562;
            1867.065,0.19049820650576; 1867.565,0.18971909374352; 1868.065,
            0.19179672777616; 1868.564,0.19569229158736; 1869.064,
            0.19439377031696; 1869.564,0.19569229158736; 1870.066,
            0.19283554479248; 1870.566,0.18893998098128; 1871.066,
            0.19569229158736; 1871.563,0.19595199584144; 1872.063,
            0.19075791075984; 1872.566,0.19439377031696; 1873.065,
            0.1964714043496; 1873.565,0.19491317882512; 1874.062,
            0.19231613628432; 1874.564,0.19101761501392; 1875.065,
            0.1925758405384; 1875.565,0.19335495330064; 1876.066,
            0.1938743618088; 1876.566,0.1951728830792; 1877.063,
            0.19179672777616; 1877.563,0.19491317882512; 1878.064,
            0.19335495330064; 1878.564,0.19179672777616; 1879.063,
            0.19335495330064; 1879.562,0.19153702352208; 1880.065,
            0.19413406606288; 1880.563,0.19049820650576; 1881.062,
            0.19465347457104; 1881.564,0.19543258733328; 1882.064,
            0.19335495330064; 1882.565,0.19153702352208; 1883.064,
            0.19465347457104; 1883.565,0.19309524904656; 1884.065,
            0.19335495330064; 1884.565,0.19439377031696; 1885.064,
            0.19491317882512; 1885.562,0.19621170009552; 1886.063,
            0.19361465755472; 1886.565,0.19491317882512; 1887.066,
            0.19543258733328; 1887.564,0.19335495330064; 1888.064,
            0.19413406606288; 1888.565,0.19075791075984; 1889.065,
            0.19309524904656; 1889.564,0.19595199584144; 1890.063,
            0.1925758405384; 1890.564,0.19335495330064; 1891.064,
            0.19335495330064; 1891.565,0.19231613628432; 1892.064,
            0.19361465755472; 1892.564,0.1925758405384; 1893.065,
            0.19595199584144; 1893.563,0.18971909374352; 1894.063,
            0.19361465755472; 1894.562,0.19283554479248; 1895.064,
            0.19283554479248; 1895.565,0.191277319268; 1896.065,
            0.19543258733328; 1896.565,0.19205643203024; 1897.066,
            0.19309524904656; 1897.566,0.19179672777616; 1898.063,
            0.1925758405384; 1898.563,0.19439377031696; 1899.064,
            0.19335495330064; 1899.564,0.19491317882512; 1900.065,
            0.1938743618088; 1900.564,0.1951728830792; 1901.065,
            0.19439377031696; 1901.565,0.1951728830792; 1902.065,
            0.1951728830792; 1902.563,0.19543258733328; 1903.063,
            0.19543258733328; 1903.565,0.19776992562; 1904.061,0.19361465755472;
            1904.564,0.19153702352208; 1905.065,0.19569229158736; 1905.565,
            0.19725051711184; 1906.063,0.1938743618088; 1906.565,
            0.1938743618088; 1907.066,0.1951728830792; 1907.564,
            0.19465347457104; 1908.066,0.19673110860368; 1908.565,
            0.19439377031696; 1909.065,0.19543258733328; 1909.565,
            0.19725051711184; 1910.065,0.19725051711184; 1910.566,
            0.19595199584144; 1911.065,0.19958785539856; 1911.565,
            0.1964714043496; 1912.065,0.19880874263632; 1912.565,
            0.19673110860368; 1913.064,0.19958785539856; 1913.564,
            0.1990684468904; 1914.064,0.19880874263632; 1914.564,
            0.19699081285776; 1915.066,0.19932815114448; 1915.562,
            0.20088637666896; 1916.063,0.19828933412816; 1916.565,
            0.19958785539856; 1917.064,0.1990684468904; 1917.565,
            0.20244460219344; 1918.065,0.19958785539856; 1918.564,
            0.20010726390672; 1919.063,0.20114608092304; 1919.564,
            0.20062667241488; 1920.064,0.19854903838224; 1920.566,
            0.20270430644752; 1921.064,0.20270430644752; 1921.565,
            0.2029640107016; 1922.063,0.20010726390672; 1922.564,
            0.19491317882512; 1923.065,0.19751022136592; 1923.565,
            0.19673110860368; 1924.062,0.19595199584144; 1924.564,
            0.2003669681608; 1925.06,0.19828933412816; 1925.565,
            0.19569229158736; 1926.064,0.19958785539856; 1926.564,
            0.1964714043496; 1927.065,0.19880874263632; 1927.565,
            0.19673110860368; 1928.062,0.19932815114448; 1928.564,0.19776992562;
            1929.063,0.19673110860368; 1929.565,0.19802962987408; 1930.064,
            0.19854903838224; 1930.565,0.19880874263632; 1931.064,
            0.1964714043496; 1931.563,0.19491317882512; 1932.063,
            0.19854903838224; 1932.565,0.19465347457104; 1933.065,
            0.19725051711184; 1933.562,0.19465347457104; 1934.065,
            0.19283554479248; 1934.563,0.1938743618088; 1935.062,
            0.19413406606288; 1935.565,0.19283554479248; 1936.062,
            0.19023850225168; 1936.564,0.18971909374352; 1937.065,
            0.19101761501392; 1937.565,0.1925758405384; 1938.065,
            0.19101761501392; 1938.567,0.191277319268; 1939.065,0.1925758405384;
            1939.563,0.19413406606288; 1940.065,0.19439377031696; 1940.566,
            0.19309524904656; 1941.063,0.19725051711184; 1941.564,
            0.19361465755472; 1942.066,0.19751022136592; 1942.565,
            0.19621170009552; 1943.066,0.19569229158736; 1943.565,
            0.1938743618088; 1944.065,0.19621170009552; 1944.562,
            0.19361465755472; 1945.065,0.19621170009552; 1945.564,
            0.19491317882512; 1946.062,0.19621170009552; 1946.565,
            0.19958785539856; 1947.062,0.19543258733328; 1947.563,
            0.19802962987408; 1948.065,0.19828933412816; 1948.564,
            0.19932815114448; 1949.061,0.19595199584144; 1949.565,
            0.20218489793936; 1950.062,0.20088637666896; 1950.563,
            0.2068595745128; 1951.065,0.20582075749648; 1951.565,
            0.2029640107016; 1952.066,0.204262531972; 1952.563,0.20088637666896;
            1953.065,0.20062667241488; 1953.565,0.20140578517712; 1954.065,
            0.20114608092304; 1954.564,0.1990684468904; 1955.065,
            0.19751022136592; 1955.566,0.19880874263632; 1956.065,
            0.19413406606288; 1956.565,0.19569229158736; 1957.065,
            0.19543258733328; 1957.564,0.19543258733328; 1958.064,
            0.19932815114448; 1958.563,0.19725051711184; 1959.063,
            0.19621170009552; 1959.565,0.19776992562; 1960.065,0.19880874263632;
            1960.564,0.19673110860368; 1961.063,0.19984755965264; 1961.565,
            0.19725051711184; 1962.063,0.19776992562; 1962.562,0.19932815114448;
            1963.064,0.19854903838224; 1963.564,0.20192519368528; 1964.065,
            0.19828933412816; 1964.564,0.19802962987408; 1965.062,
            0.19751022136592; 1965.562,0.19880874263632; 1966.064,
            0.19854903838224; 1966.564,0.19569229158736; 1967.065,
            0.19491317882512; 1967.564,0.19543258733328; 1968.065,
            0.19465347457104; 1968.566,0.19413406606288; 1969.065,
            0.19880874263632; 1969.563,0.20010726390672; 1970.064,
            0.20192519368528; 1970.562,0.19673110860368; 1971.065,
            0.19854903838224; 1971.564,0.20088637666896; 1972.063,
            0.2003669681608; 1972.565,0.19854903838224; 1973.061,
            0.20114608092304; 1973.564,0.20270430644752; 1974.065,
            0.20322371495568; 1974.566,0.2016654894312; 1975.064,
            0.19932815114448; 1975.565,0.20400282771792; 1976.064,
            0.20244460219344; 1976.564,0.2003669681608; 1977.065,
            0.19595199584144; 1977.564,0.1990684468904; 1978.064,
            0.19673110860368; 1978.564,0.19854903838224; 1979.066,
            0.19543258733328; 1979.564,0.1938743618088; 1980.066,
            0.1951728830792; 1980.565,0.19751022136592; 1981.065,
            0.19569229158736; 1981.562,0.19699081285776; 1982.065,
            0.19309524904656; 1982.565,0.1964714043496; 1983.065,
            0.19595199584144; 1983.564,0.1938743618088; 1984.066,
            0.19465347457104; 1984.565,0.19283554479248; 1985.065,
            0.19621170009552; 1985.565,0.191277319268; 1986.065,
            0.19569229158736; 1986.566,0.19439377031696; 1987.066,
            0.19621170009552; 1987.565,0.19595199584144; 1988.066,
            0.19491317882512; 1988.565,0.19413406606288; 1989.065,
            0.19439377031696; 1989.565,0.19491317882512; 1990.065,
            0.1938743618088; 1990.566,0.19673110860368; 1991.065,
            0.1990684468904; 1991.565,0.20322371495568; 1992.063,
            0.20582075749648; 1992.565,0.20582075749648; 1993.066,
            0.20400282771792; 1993.567,0.20192519368528; 1994.064,
            0.20114608092304; 1994.562,0.20140578517712; 1995.065,
            0.19699081285776; 1995.566,0.19802962987408; 1996.064,
            0.1951728830792; 1996.564,0.19802962987408; 1997.065,
            0.19283554479248; 1997.566,0.19854903838224; 1998.064,
            0.2003669681608; 1998.562,0.20062667241488; 1999.064,
            0.20374312346384; 1999.565,0.20140578517712; 2000.063,
            0.19725051711184; 2000.566,0.19802962987408; 2001.064,
            0.19673110860368; 2001.563,0.19699081285776; 2002.065,
            0.19751022136592; 2002.565,0.19802962987408; 2003.065,
            0.19543258733328; 2003.564,0.19673110860368; 2004.066,
            0.1964714043496; 2004.562,0.19984755965264; 2005.063,0.19776992562;
            2005.564,0.19984755965264; 2006.066,0.19932815114448; 2006.566,
            0.2003669681608; 2007.064,0.20010726390672; 2007.566,
            0.20322371495568; 2008.065,0.20348341920976; 2008.563,
            0.20114608092304; 2009.066,0.19725051711184; 2009.565,
            0.20062667241488; 2010.062,0.20374312346384; 2010.563,
            0.20322371495568; 2011.063,0.20218489793936; 2011.564,
            0.19621170009552; 2012.067,0.19621170009552; 2012.565,
            0.19621170009552; 2013.062,0.19802962987408; 2013.567,
            0.19699081285776; 2014.065,0.19543258733328; 2014.566,
            0.19439377031696; 2015.063,0.19335495330064; 2015.566,
            0.19179672777616; 2016.064,0.19465347457104; 2016.564,
            0.1964714043496; 2017.067,0.19283554479248; 2017.565,
            0.19699081285776; 2018.065,0.19621170009552; 2018.565,
            0.1938743618088; 2019.066,0.19776992562; 2019.566,0.19699081285776;
            2020.061,0.19802962987408; 2020.565,0.20062667241488; 2021.064,
            0.2003669681608; 2021.566,0.19751022136592; 2022.065,
            0.19439377031696; 2022.566,0.19673110860368; 2023.065,
            0.1951728830792; 2023.562,0.20218489793936; 2024.065,
            0.19699081285776; 2024.563,0.19828933412816; 2025.062,
            0.19932815114448; 2025.563,0.19984755965264; 2026.064,
            0.20010726390672; 2026.565,0.20478194048016; 2027.066,
            0.20634016600464; 2027.565,0.20893720854544; 2028.066,
            0.20737898302096; 2028.564,0.20608046175056; 2029.066,
            0.19828933412816; 2029.564,0.1990684468904; 2030.061,
            0.20218489793936; 2030.566,0.2003669681608; 2031.065,
            0.19802962987408; 2031.566,0.19699081285776; 2032.063,
            0.20010726390672; 2032.565,0.19309524904656; 2033.066,
            0.19854903838224; 2033.565,0.19673110860368; 2034.067,
            0.1964714043496; 2034.567,0.19621170009552; 2035.062,
            0.19802962987408; 2035.564,0.19958785539856; 2036.065,
            0.19880874263632; 2036.565,0.20244460219344; 2037.065,
            0.19984755965264; 2037.566,0.19751022136592; 2038.065,
            0.19621170009552; 2038.565,0.20010726390672; 2039.064,
            0.19283554479248; 2039.565,0.19699081285776; 2040.066,
            0.19543258733328; 2040.565,0.19751022136592; 2041.066,
            0.19984755965264; 2041.564,0.2003669681608; 2042.066,
            0.19802962987408; 2042.565,0.19751022136592; 2043.065,
            0.1964714043496; 2043.565,0.20140578517712; 2044.066,
            0.20114608092304; 2044.566,0.20270430644752; 2045.065,
            0.20010726390672; 2045.566,0.19984755965264; 2046.065,
            0.20140578517712; 2046.561,0.19802962987408; 2047.066,
            0.19958785539856; 2047.565,0.19828933412816; 2048.065,
            0.19854903838224; 2048.565,0.19699081285776; 2049.066,
            0.19725051711184; 2049.566,0.19802962987408; 2050.066,
            0.19413406606288; 2050.565,0.1938743618088; 2051.064,
            0.19595199584144; 2051.562,0.19621170009552; 2052.062,
            0.19413406606288; 2052.564,0.19335495330064; 2053.066,
            0.19153702352208; 2053.566,0.19491317882512; 2054.066,
            0.1951728830792; 2054.566,0.19439377031696; 2055.065,
            0.19335495330064; 2055.562,0.19491317882512; 2056.065,
            0.19413406606288; 2056.566,0.1964714043496; 2057.065,
            0.19439377031696; 2057.562,0.19465347457104; 2058.065,
            0.19543258733328; 2058.565,0.19595199584144; 2059.066,
            0.19491317882512; 2059.564,0.19491317882512; 2060.063,
            0.19179672777616; 2060.563,0.191277319268; 2061.065,0.1925758405384;
            2061.566,0.19231613628432; 2062.065,0.19569229158736; 2062.565,
            0.19699081285776; 2063.066,0.19465347457104; 2063.563,
            0.1964714043496; 2064.067,0.19802962987408; 2064.565,
            0.19569229158736; 2065.066,0.19932815114448; 2065.565,
            0.20062667241488; 2066.065,0.20218489793936; 2066.565,
            0.20452223622608; 2067.066,0.20374312346384; 2067.564,
            0.20452223622608; 2068.063,0.2029640107016; 2068.565,
            0.20114608092304; 2069.065,0.20244460219344; 2069.562,
            0.20088637666896; 2070.062,0.1990684468904; 2070.575,
            0.19984755965264; 2071.07,0.19958785539856; 2071.565,
            0.20088637666896; 2072.064,0.19595199584144; 2072.565,
            0.2016654894312; 2073.065,0.1990684468904; 2073.563,
            0.19984755965264; 2074.066,0.19984755965264; 2074.566,
            0.20088637666896; 2075.064,0.2029640107016; 2075.565,
            0.20140578517712; 2076.063,0.20088637666896; 2076.564,
            0.1990684468904; 2077.065,0.2003669681608; 2077.566,
            0.20010726390672; 2078.066,0.19984755965264; 2078.562,
            0.20062667241488; 2079.065,0.20140578517712; 2079.563,
            0.2003669681608; 2080.064,0.19984755965264; 2080.566,
            0.19751022136592; 2081.063,0.19569229158736; 2081.563,
            0.19595199584144; 2082.065,0.19283554479248; 2082.564,
            0.19439377031696; 2083.065,0.19543258733328; 2083.564,
            0.19880874263632; 2084.066,0.20114608092304; 2084.564,
            0.1990684468904; 2085.066,0.20140578517712; 2085.564,
            0.20270430644752; 2086.065,0.2003669681608; 2086.562,
            0.2029640107016; 2087.062,0.1990684468904; 2087.564,
            0.19621170009552; 2088.065,0.2003669681608; 2088.565,
            0.20088637666896; 2089.065,0.20270430644752; 2089.565,
            0.20322371495568; 2090.065,0.19984755965264; 2090.564,
            0.20192519368528; 2091.063,0.2003669681608; 2091.565,
            0.20270430644752; 2092.065,0.20452223622608; 2092.566,
            0.19958785539856; 2093.065,0.20244460219344; 2093.566,0.19776992562;
            2094.064,0.19958785539856; 2094.565,0.19828933412816; 2095.065,
            0.19828933412816; 2095.568,0.19725051711184; 2096.065,
            0.19595199584144; 2096.565,0.19854903838224; 2097.067,
            0.19802962987408; 2097.565,0.1951728830792; 2098.065,
            0.1938743618088; 2098.565,0.19854903838224; 2099.066,
            0.19543258733328; 2099.565,0.19621170009552; 2100.066,
            0.19621170009552; 2100.566,0.19569229158736; 2101.065,
            0.19335495330064; 2101.565,0.19543258733328; 2102.064,
            0.1925758405384; 2102.565,0.18971909374352; 2103.065,
            0.19023850225168; 2103.564,0.19179672777616; 2104.065,
            0.191277319268; 2104.567,0.19335495330064; 2105.064,
            0.19595199584144; 2105.565,0.19491317882512; 2106.065,
            0.1925758405384; 2106.565,0.19231613628432; 2107.065,0.19776992562;
            2107.566,0.1938743618088; 2108.068,0.19075791075984; 2108.562,
            0.191277319268; 2109.066,0.19361465755472; 2109.564,
            0.19751022136592; 2110.062,0.1964714043496; 2110.562,
            0.19465347457104; 2111.063,0.19465347457104; 2111.562,
            0.19361465755472; 2112.062,0.1925758405384; 2112.566,
            0.19491317882512; 2113.065,0.19231613628432; 2113.564,
            0.191277319268; 2114.066,0.1938743618088; 2114.562,0.19309524904656;
            2115.062,0.19413406606288; 2115.565,0.19569229158736; 2116.066,
            0.19413406606288; 2116.563,0.19880874263632; 2117.065,
            0.19283554479248; 2117.563,0.19958785539856; 2118.063,
            0.19725051711184; 2118.562,0.19413406606288; 2119.063,0.19776992562;
            2119.562,0.1951728830792; 2120.062,0.19465347457104; 2120.563,
            0.19439377031696; 2121.063,0.19776992562; 2121.562,0.19569229158736;
            2122.063,0.19776992562; 2122.563,0.1990684468904; 2123.063,
            0.19828933412816; 2123.565,0.19854903838224; 2124.064,
            0.19984755965264; 2124.564,0.19932815114448; 2125.064,
            0.19880874263632; 2125.565,0.19802962987408; 2126.064,
            0.19958785539856; 2126.564,0.19958785539856; 2127.064,
            0.2029640107016; 2127.564,0.20218489793936; 2128.065,
            0.20452223622608; 2128.563,0.20348341920976; 2129.064,
            0.20374312346384; 2129.566,0.20348341920976; 2130.065,
            0.20504164473424; 2130.564,0.20763868727504; 2131.066,
            0.2068595745128; 2131.565,0.20478194048016; 2132.066,0.204262531972;
            2132.566,0.2016654894312; 2133.065,0.20244460219344; 2133.563,
            0.20322371495568; 2134.063,0.20322371495568; 2134.565,
            0.2029640107016; 2135.065,0.20322371495568; 2135.563,
            0.20530134898832; 2136.065,0.20582075749648; 2136.564,
            0.20244460219344; 2137.066,0.20374312346384; 2137.563,
            0.19984755965264; 2138.066,0.19880874263632; 2138.565,
            0.2016654894312; 2139.064,0.2055610532424; 2139.563,
            0.20062667241488; 2140.064,0.20478194048016; 2140.564,
            0.20530134898832; 2141.064,0.20530134898832; 2141.563,
            0.20504164473424; 2142.064,0.20659987025872; 2142.562,
            0.20841780003728; 2143.065,0.20763868727504; 2143.566,
            0.20711927876688; 2144.062,0.20763868727504; 2144.565,
            0.20582075749648; 2145.063,0.20659987025872; 2145.563,
            0.20711927876688; 2146.066,0.20608046175056; 2146.562,
            0.204262531972; 2147.062,0.2029640107016; 2147.565,0.2016654894312;
            2148.065,0.20530134898832; 2148.563,0.20374312346384; 2149.066,
            0.20114608092304; 2149.565,0.20400282771792; 2150.066,
            0.20010726390672; 2150.565,0.20010726390672; 2151.066,
            0.19854903838224; 2151.566,0.19776992562; 2152.063,0.20010726390672;
            2152.565,0.19828933412816; 2153.066,0.20088637666896; 2153.566,
            0.19725051711184; 2154.065,0.20114608092304; 2154.562,
            0.19854903838224; 2155.062,0.20088637666896; 2155.563,
            0.20192519368528; 2156.064,0.19751022136592; 2156.564,
            0.20114608092304; 2157.065,0.1951728830792; 2157.565,
            0.19439377031696; 2158.065,0.19543258733328; 2158.564,
            0.20010726390672; 2159.064,0.20010726390672; 2159.565,
            0.2003669681608; 2160.065,0.20192519368528; 2160.563,
            0.20010726390672; 2161.064,0.20010726390672; 2161.566,
            0.19854903838224; 2162.064,0.20010726390672; 2162.564,
            0.20218489793936; 2163.064,0.20218489793936; 2163.566,
            0.20192519368528; 2164.065,0.1964714043496; 2164.563,
            0.20062667241488; 2165.064,0.20140578517712; 2165.565,
            0.19699081285776; 2166.065,0.20218489793936; 2166.565,
            0.20088637666896; 2167.064,0.20010726390672; 2167.565,
            0.20010726390672; 2168.065,0.19880874263632; 2168.564,
            0.19802962987408; 2169.066,0.19491317882512; 2169.564,
            0.19595199584144; 2170.066,0.19569229158736; 2170.565,
            0.19699081285776; 2171.066,0.19569229158736; 2171.564,
            0.19802962987408; 2172.066,0.19751022136592; 2172.565,
            0.20192519368528; 2173.065,0.20140578517712; 2173.565,
            0.2029640107016; 2174.066,0.2029640107016; 2174.564,
            0.19984755965264; 2175.064,0.20062667241488; 2175.564,
            0.20192519368528; 2176.065,0.20088637666896; 2176.565,
            0.2003669681608; 2177.065,0.20088637666896; 2177.565,
            0.19984755965264; 2178.064,0.19984755965264; 2178.566,
            0.19880874263632; 2179.064,0.20062667241488; 2179.563,
            0.19725051711184; 2180.066,0.2003669681608; 2180.563,
            0.19802962987408; 2181.065,0.19802962987408; 2181.565,
            0.19880874263632; 2182.065,0.19751022136592; 2182.563,
            0.19543258733328; 2183.066,0.19283554479248; 2183.564,
            0.1925758405384; 2184.064,0.19231613628432; 2184.562,
            0.19465347457104; 2185.066,0.19854903838224; 2185.565,
            0.19439377031696; 2186.065,0.19776992562; 2186.566,0.19725051711184;
            2187.065,0.20010726390672; 2187.565,0.1990684468904; 2188.065,
            0.1990684468904; 2188.565,0.19776992562; 2189.064,0.19725051711184;
            2189.565,0.19828933412816; 2190.065,0.19725051711184; 2190.564,
            0.19958785539856; 2191.064,0.1990684468904; 2191.564,
            0.1990684468904; 2192.065,0.2003669681608; 2192.564,
            0.20062667241488; 2193.066,0.20062667241488; 2193.564,
            0.1990684468904; 2194.065,0.20348341920976; 2194.565,
            0.19984755965264; 2195.065,0.20088637666896; 2195.566,
            0.20010726390672; 2196.064,0.2003669681608; 2196.565,
            0.2003669681608; 2197.064,0.19854903838224; 2197.562,
            0.19828933412816; 2198.064,0.20452223622608; 2198.564,
            0.20270430644752; 2199.065,0.19751022136592; 2199.563,
            0.19802962987408; 2200.065,0.19984755965264; 2200.565,
            0.19854903838224; 2201.064,0.20010726390672; 2201.565,
            0.19491317882512; 2202.065,0.19958785539856; 2202.563,
            0.19984755965264; 2203.064,0.19802962987408; 2203.565,
            0.20062667241488; 2204.067,0.19699081285776; 2204.564,
            0.19932815114448; 2205.065,0.19854903838224; 2205.562,
            0.19802962987408; 2206.065,0.19491317882512; 2206.565,
            0.19751022136592; 2207.066,0.1951728830792; 2207.565,
            0.19465347457104; 2208.065,0.19595199584144; 2208.564,
            0.19595199584144; 2209.065,0.19828933412816; 2209.566,
            0.19802962987408; 2210.065,0.19725051711184; 2210.561,
            0.19699081285776; 2211.065,0.19802962987408; 2211.563,
            0.1990684468904; 2212.065,0.19802962987408; 2212.565,
            0.20088637666896; 2213.066,0.20244460219344; 2213.564,
            0.20140578517712; 2214.065,0.20218489793936; 2214.565,
            0.19932815114448; 2215.065,0.20114608092304; 2215.561,
            0.20270430644752; 2216.064,0.20114608092304; 2216.563,
            0.20400282771792; 2217.064,0.19984755965264; 2217.563,
            0.20088637666896; 2218.066,0.19984755965264; 2218.566,
            0.20114608092304; 2219.066,0.1990684468904; 2219.565,
            0.20114608092304; 2220.064,0.19932815114448; 2220.561,
            0.19880874263632; 2221.066,0.20088637666896; 2221.565,
            0.2003669681608; 2222.066,0.20244460219344; 2222.565,
            0.19932815114448; 2223.066,0.20010726390672; 2223.566,
            0.20192519368528; 2224.065,0.20088637666896; 2224.566,
            0.20400282771792; 2225.065,0.2016654894312; 2225.562,
            0.2003669681608; 2226.065,0.20322371495568; 2226.565,
            0.2029640107016; 2227.067,0.20530134898832; 2227.564,
            0.20452223622608; 2228.065,0.20608046175056; 2228.565,
            0.20322371495568; 2229.067,0.20608046175056; 2229.565,
            0.204262531972; 2230.066,0.2081580957832; 2230.562,0.20893720854544;
            2231.065,0.20789839152912; 2231.565,0.20659987025872; 2232.065,
            0.19958785539856; 2232.565,0.19958785539856; 2233.065,
            0.19828933412816; 2233.567,0.19854903838224; 2234.067,
            0.1964714043496; 2234.566,0.19880874263632; 2235.066,
            0.19595199584144; 2235.562,0.19543258733328; 2236.065,
            0.1951728830792; 2236.562,0.19802962987408; 2237.065,
            0.19543258733328; 2237.563,0.19725051711184; 2238.066,
            0.19283554479248; 2238.565,0.19413406606288; 2239.066,
            0.19621170009552; 2239.566,0.19361465755472; 2240.066,
            0.1951728830792; 2240.563,0.19283554479248; 2241.065,
            0.19595199584144; 2241.566,0.1938743618088; 2242.065,
            0.1938743618088; 2242.566,0.19413406606288; 2243.066,
            0.19491317882512; 2243.565,0.19725051711184; 2244.064,
            0.19465347457104; 2244.566,0.19569229158736; 2245.065,
            0.19880874263632; 2245.562,0.20062667241488; 2246.065,
            0.19880874263632; 2246.566,0.19309524904656; 2247.066,
            0.19075791075984; 2247.564,0.1925758405384; 2248.066,
            0.19491317882512; 2248.565,0.19335495330064; 2249.067,
            0.19802962987408; 2249.565,0.1925758405384; 2250.066,
            0.19335495330064; 2250.564,0.19205643203024; 2251.064,
            0.19153702352208; 2251.565,0.19231613628432; 2252.065,
            0.19569229158736; 2252.565,0.19439377031696; 2253.066,
            0.19595199584144; 2253.566,0.19984755965264; 2254.065,
            0.19802962987408; 2254.567,0.1964714043496; 2255.066,
            0.1990684468904; 2255.563,0.19673110860368; 2256.066,
            0.1990684468904; 2256.564,0.19958785539856; 2257.065,0.19776992562;
            2257.565,0.20010726390672; 2258.065,0.20010726390672; 2258.566,
            0.20452223622608; 2259.067,0.19932815114448; 2259.565,
            0.20140578517712; 2260.064,0.204262531972; 2260.561,0.2029640107016;
            2261.065,0.20140578517712; 2261.565,0.20348341920976; 2262.065,
            0.2016654894312; 2262.564,0.20192519368528; 2263.065,
            0.2029640107016; 2263.566,0.19984755965264; 2264.065,
            0.20114608092304; 2264.566,0.20140578517712; 2265.064,
            0.20010726390672; 2265.561,0.19776992562; 2266.065,0.19932815114448;
            2266.567,0.19932815114448; 2267.066,0.19854903838224; 2267.567,
            0.19673110860368; 2268.064,0.2003669681608; 2268.566,
            0.19958785539856; 2269.066,0.19776992562; 2269.565,0.19465347457104;
            2270.065,0.19673110860368; 2270.562,0.19413406606288; 2271.067,
            0.1951728830792; 2271.566,0.19802962987408; 2272.066,
            0.20062667241488; 2272.565,0.19880874263632; 2273.066,
            0.19854903838224; 2273.565,0.20218489793936; 2274.065,
            0.20062667241488; 2274.564,0.19932815114448; 2275.065,
            0.19854903838224; 2275.565,0.1990684468904; 2276.067,
            0.19880874263632; 2276.565,0.20062667241488; 2277.066,
            0.20114608092304; 2277.566,0.20062667241488; 2278.067,
            0.20270430644752; 2278.565,0.2003669681608; 2279.064,
            0.20140578517712; 2279.564,0.20270430644752; 2280.064,0.19776992562;
            2280.566,0.20192519368528; 2281.065,0.19751022136592; 2281.565,
            0.20062667241488; 2282.066,0.1990684468904; 2282.566,0.19776992562;
            2283.067,0.19569229158736; 2283.564,0.2016654894312; 2284.067,
            0.20270430644752; 2284.565,0.19984755965264; 2285.064,
            0.19725051711184; 2285.565,0.19725051711184; 2286.066,
            0.20010726390672; 2286.567,0.20010726390672; 2287.065,
            0.20010726390672; 2287.565,0.19854903838224; 2288.067,
            0.20192519368528; 2288.566,0.19725051711184; 2289.065,0.19776992562;
            2289.566,0.19595199584144; 2290.067,0.2003669681608; 2290.566,
            0.20140578517712; 2291.067,0.19958785539856; 2291.566,
            0.20244460219344; 2292.066,0.19984755965264; 2292.565,
            0.204262531972; 2293.066,0.20374312346384; 2293.565,
            0.20218489793936; 2294.066,0.20763868727504; 2294.566,
            0.20478194048016; 2295.066,0.20582075749648; 2295.567,
            0.20582075749648; 2296.066,0.20711927876688; 2296.565,
            0.21101484257808; 2297.066,0.20530134898832; 2297.566,
            0.20400282771792; 2298.065,0.20400282771792; 2298.565,
            0.20270430644752; 2299.065,0.2055610532424; 2299.566,
            0.2068595745128; 2300.064,0.2055610532424; 2300.566,0.204262531972;
            2301.065,0.20348341920976; 2301.566,0.20400282771792; 2302.065,
            0.20530134898832; 2302.565,0.20582075749648; 2303.066,
            0.20322371495568; 2303.566,0.20737898302096; 2304.066,
            0.20841780003728; 2304.565,0.204262531972; 2305.066,
            0.20608046175056; 2305.564,0.2081580957832; 2306.065,
            0.20348341920976; 2306.565,0.20971632130768; 2307.065,
            0.20504164473424; 2307.563,0.20841780003728; 2308.064,
            0.20737898302096; 2308.565,0.20789839152912; 2309.064,
            0.20737898302096; 2309.565,0.20919691279952; 2310.064,
            0.2081580957832; 2310.566,0.2094566170536; 2311.066,
            0.21049543406992; 2311.564,0.20893720854544; 2312.067,
            0.20893720854544; 2312.566,0.20711927876688; 2313.066,
            0.20893720854544; 2313.566,0.20218489793936; 2314.066,
            0.20270430644752; 2314.566,0.20088637666896; 2315.065,
            0.19932815114448; 2315.567,0.20062667241488; 2316.066,
            0.20400282771792; 2316.566,0.20478194048016; 2317.067,
            0.20400282771792; 2317.567,0.20088637666896; 2318.063,
            0.2003669681608; 2318.567,0.20192519368528; 2319.065,
            0.19828933412816; 2319.567,0.19828933412816; 2320.066,
            0.19751022136592; 2320.565,0.19958785539856; 2321.067,
            0.1964714043496; 2321.566,0.19751022136592; 2322.064,
            0.19543258733328; 2322.566,0.20010726390672; 2323.066,
            0.19543258733328; 2323.565,0.2016654894312; 2324.066,
            0.1951728830792; 2324.566,0.19413406606288; 2325.065,
            0.19465347457104; 2325.565,0.19699081285776; 2326.066,
            0.19932815114448; 2326.565,0.19751022136592; 2327.065,
            0.19673110860368; 2327.565,0.20010726390672; 2328.062,
            0.2016654894312; 2328.564,0.20010726390672; 2329.066,
            0.20192519368528; 2329.565,0.19802962987408; 2330.066,0.19776992562;
            2330.567,0.19751022136592; 2331.065,0.20062667241488; 2331.565,
            0.19984755965264; 2332.065,0.19958785539856; 2332.565,
            0.19958785539856; 2333.066,0.19673110860368; 2333.567,
            0.19802962987408; 2334.067,0.19776992562; 2334.567,0.19335495330064;
            2335.066,0.19880874263632; 2335.565,0.19984755965264; 2336.066,
            0.20062667241488; 2336.565,0.20062667241488; 2337.065,
            0.1990684468904; 2337.565,0.20192519368528; 2338.066,
            0.20140578517712; 2338.565,0.2016654894312; 2339.066,
            0.20192519368528; 2339.566,0.2003669681608; 2340.066,
            0.20010726390672; 2340.567,0.2029640107016; 2341.066,
            0.2016654894312; 2341.567,0.20140578517712; 2342.065,
            0.19958785539856; 2342.566,0.20088637666896; 2343.066,
            0.2029640107016; 2343.565,0.20088637666896; 2344.063,0.204262531972;
            2344.567,0.20140578517712; 2345.064,0.20218489793936; 2345.564,
            0.19751022136592; 2346.065,0.19958785539856; 2346.567,
            0.19699081285776; 2347.063,0.20114608092304; 2347.564,
            0.19725051711184; 2348.064,0.19802962987408; 2348.565,
            0.19932815114448; 2349.067,0.19621170009552; 2349.564,
            0.19595199584144; 2350.065,0.19335495330064; 2350.565,
            0.19725051711184; 2351.065,0.19543258733328; 2351.566,
            0.19569229158736; 2352.066,0.19491317882512; 2352.564,
            0.19725051711184; 2353.065,0.19621170009552; 2353.564,
            0.19465347457104; 2354.065,0.1938743618088; 2354.564,
            0.19828933412816; 2355.063,0.19828933412816; 2355.563,
            0.19569229158736; 2356.066,0.19699081285776; 2356.565,
            0.19751022136592; 2357.063,0.19828933412816; 2357.565,
            0.19725051711184; 2358.061,0.19751022136592; 2358.566,
            0.19595199584144; 2359.066,0.19621170009552; 2359.566,
            0.19699081285776; 2360.064,0.19725051711184; 2360.565,
            0.19854903838224; 2361.066,0.19776992562; 2361.567,0.19828933412816;
            2362.065,0.20140578517712; 2362.565,0.20400282771792; 2363.066,
            0.2081580957832; 2363.566,0.20789839152912; 2364.066,
            0.20711927876688; 2364.567,0.20452223622608; 2365.066,
            0.20140578517712; 2365.565,0.2016654894312; 2366.099,
            0.19828933412816; 2366.567,0.20010726390672; 2367.065,
            0.20140578517712; 2367.563,0.19569229158736; 2368.066,
            0.19751022136592; 2368.565,0.19673110860368; 2369.064,
            0.1964714043496; 2369.566,0.20348341920976; 2370.064,
            0.20088637666896; 2370.566,0.2016654894312; 2371.067,
            0.20192519368528; 2371.565,0.19776992562; 2372.066,0.1990684468904;
            2372.566,0.19984755965264; 2373.066,0.20218489793936; 2373.566,
            0.1964714043496; 2374.067,0.19491317882512; 2374.566,
            0.19413406606288; 2375.065,0.19361465755472; 2375.565,
            0.19595199584144; 2376.067,0.19958785539856; 2376.565,
            0.2029640107016; 2377.066,0.20140578517712; 2377.566,
            0.19932815114448; 2378.066,0.20140578517712; 2378.565,
            0.2029640107016; 2379.065,0.20270430644752; 2379.566,
            0.20504164473424; 2380.065,0.2003669681608; 2380.566,
            0.20244460219344; 2381.065,0.20504164473424; 2381.566,
            0.20400282771792; 2382.066,0.1990684468904; 2382.565,
            0.2003669681608; 2383.065,0.20244460219344; 2383.563,
            0.2003669681608; 2384.063,0.19569229158736; 2384.566,
            0.19699081285776; 2385.067,0.19751022136592; 2385.566,
            0.19439377031696; 2386.065,0.19880874263632; 2386.565,
            0.1964714043496; 2387.067,0.19569229158736; 2387.566,
            0.19543258733328; 2388.065,0.1964714043496; 2388.565,
            0.1964714043496; 2389.066,0.19699081285776; 2389.566,
            0.1964714043496; 2390.067,0.1964714043496; 2390.565,0.19776992562;
            2391.066,0.19751022136592; 2391.564,0.19984755965264; 2392.065,
            0.19725051711184; 2392.567,0.19491317882512; 2393.065,
            0.19439377031696; 2393.566,0.19491317882512; 2394.065,
            0.19153702352208; 2394.565,0.1964714043496; 2395.066,
            0.1951728830792; 2395.564,0.19621170009552; 2396.064,
            0.19673110860368; 2396.565,0.19621170009552; 2397.065,
            0.1951728830792; 2397.563,0.19984755965264; 2398.066,
            0.20192519368528; 2398.566,0.20062667241488; 2399.067,
            0.20478194048016; 2399.566,0.20374312346384; 2400.066,
            0.20608046175056; 2400.564,0.20348341920976; 2401.066,
            0.20530134898832; 2401.567,0.19958785539856; 2402.065,
            0.20504164473424; 2402.567,0.20062667241488; 2403.064,
            0.20218489793936; 2403.565,0.20140578517712; 2404.064,
            0.2016654894312; 2404.565,0.20088637666896; 2405.065,
            0.20218489793936; 2405.566,0.19880874263632; 2406.066,
            0.19932815114448; 2406.566,0.19932815114448; 2407.064,
            0.1990684468904; 2407.566,0.19958785539856; 2408.066,
            0.2003669681608; 2408.563,0.19984755965264; 2409.066,
            0.19984755965264; 2409.566,0.19984755965264; 2410.066,
            0.19595199584144; 2410.566,0.20114608092304; 2411.065,
            0.20062667241488; 2411.562,0.19854903838224; 2412.066,
            0.19984755965264; 2412.565,0.20010726390672; 2413.066,
            0.19802962987408; 2413.565,0.19958785539856; 2414.065,
            0.2003669681608; 2414.567,0.19751022136592; 2415.065,
            0.19958785539856; 2415.566,0.19932815114448; 2416.067,
            0.20088637666896; 2416.567,0.19699081285776; 2417.066,
            0.19932815114448; 2417.565,0.19413406606288; 2418.065,
            0.19543258733328; 2418.563,0.19413406606288; 2419.066,
            0.20114608092304; 2419.563,0.19984755965264; 2420.065,
            0.20218489793936; 2420.564,0.20192519368528; 2421.066,
            0.2016654894312; 2421.567,0.19984755965264; 2422.066,
            0.2003669681608; 2422.567,0.20218489793936; 2423.065,
            0.2029640107016; 2423.565,0.20348341920976; 2424.063,
            0.20218489793936; 2424.565,0.20400282771792; 2425.067,
            0.20140578517712; 2425.563,0.20478194048016; 2426.064,
            0.20270430644752; 2426.567,0.2016654894312; 2427.066,
            0.19854903838224; 2427.565,0.20088637666896; 2428.066,
            0.19854903838224; 2428.566,0.19880874263632; 2429.066,
            0.1990684468904; 2429.566,0.19932815114448; 2430.066,
            0.19880874263632; 2430.565,0.19984755965264; 2431.066,
            0.19802962987408; 2431.565,0.19828933412816; 2432.066,
            0.19673110860368; 2432.567,0.1938743618088; 2433.066,
            0.19621170009552; 2433.565,0.19439377031696; 2434.067,
            0.1964714043496; 2434.565,0.19439377031696; 2435.065,
            0.1938743618088; 2435.562,0.19439377031696; 2436.067,
            0.19465347457104; 2436.564,0.19569229158736; 2437.066,
            0.1938743618088; 2437.567,0.19725051711184; 2438.066,
            0.19673110860368; 2438.567,0.19854903838224; 2439.066,
            0.1951728830792; 2439.567,0.19725051711184; 2440.066,
            0.19595199584144; 2440.567,0.19673110860368; 2441.067,
            0.19673110860368; 2441.563,0.19984755965264; 2442.062,
            0.19958785539856; 2442.563,0.19958785539856; 2443.067,
            0.19880874263632; 2443.565,0.19776992562; 2444.066,0.19699081285776;
            2444.562,0.1964714043496; 2445.065,0.19776992562; 2445.567,
            0.19621170009552; 2446.065,0.19984755965264; 2446.566,
            0.19621170009552; 2447.066,0.19751022136592; 2447.565,0.19776992562;
            2448.066,0.1990684468904; 2448.565,0.19880874263632; 2449.064,
            0.19673110860368; 2449.565,0.19932815114448; 2450.066,
            0.19958785539856; 2450.565,0.19854903838224; 2451.065,
            0.1990684468904; 2451.566,0.20192519368528; 2452.067,
            0.19958785539856; 2452.564,0.2003669681608; 2453.066,
            0.20374312346384; 2453.566,0.20659987025872; 2454.065,
            0.20659987025872; 2454.565,0.20763868727504; 2455.066,
            0.20582075749648; 2455.566,0.20530134898832; 2456.064,
            0.19984755965264; 2456.565,0.20192519368528; 2457.065,
            0.20010726390672; 2457.565,0.19751022136592; 2458.066,
            0.20088637666896; 2458.566,0.19699081285776; 2459.067,
            0.19828933412816; 2459.566,0.19595199584144; 2460.065,
            0.19543258733328; 2460.565,0.2003669681608; 2461.066,
            0.20088637666896; 2461.566,0.19854903838224; 2462.066,
            0.19984755965264; 2462.565,0.2003669681608; 2463.065,
            0.20010726390672; 2463.567,0.19958785539856; 2464.065,
            0.19958785539856; 2464.567,0.20140578517712; 2465.065,
            0.20062667241488; 2465.561,0.19673110860368; 2466.066,
            0.20062667241488; 2466.564,0.19673110860368; 2467.066,
            0.1990684468904; 2467.566,0.19854903838224; 2468.065,
            0.19491317882512; 2468.566,0.19621170009552; 2469.065,
            0.19828933412816; 2469.565,0.19984755965264; 2470.066,
            0.19932815114448; 2470.565,0.20062667241488; 2471.064,
            0.20088637666896; 2471.566,0.20192519368528; 2472.062,
            0.19828933412816; 2472.566,0.19725051711184; 2473.066,
            0.2003669681608; 2473.566,0.2029640107016; 2474.067,
            0.20348341920976; 2474.566,0.20192519368528; 2475.065,
            0.2003669681608; 2475.565,0.20244460219344; 2476.063,
            0.2016654894312; 2476.566,0.20452223622608; 2477.066,
            0.20062667241488; 2477.565,0.19984755965264; 2478.067,
            0.20114608092304; 2478.565,0.20062667241488; 2479.067,
            0.19932815114448; 2479.566,0.19465347457104; 2480.065,
            0.19725051711184; 2480.566,0.19958785539856; 2481.066,
            0.19595199584144; 2481.564,0.19595199584144; 2482.065,
            0.19725051711184; 2482.567,0.19776992562; 2483.066,0.19725051711184;
            2483.565,0.19543258733328; 2484.067,0.19439377031696; 2484.564,
            0.19595199584144; 2485.066,0.19309524904656; 2485.566,
            0.19361465755472; 2486.066,0.19283554479248; 2486.565,
            0.19621170009552; 2487.065,0.19595199584144; 2487.564,
            0.19361465755472; 2488.065,0.19621170009552; 2488.562,
            0.19569229158736; 2489.065,0.1964714043496; 2489.565,
            0.19725051711184; 2490.066,0.19751022136592; 2490.565,0.19776992562;
            2491.064,0.19932815114448; 2491.566,0.19802962987408; 2492.065,
            0.1990684468904; 2492.565,0.19880874263632; 2493.064,
            0.19984755965264; 2493.566,0.19751022136592; 2494.065,
            0.1964714043496; 2494.562,0.19465347457104; 2495.063,
            0.19621170009552; 2495.564,0.19802962987408; 2496.063,
            0.19725051711184; 2496.566,0.1990684468904; 2497.067,
            0.19751022136592; 2497.565,0.19828933412816; 2498.063,
            0.19673110860368; 2498.566,0.19725051711184; 2499.063,
            0.19854903838224; 2499.565,0.2016654894312; 2500.065,
            0.2003669681608; 2500.567,0.20088637666896; 2501.063,
            0.19673110860368; 2501.567,0.1990684468904; 2502.065,
            0.19880874263632; 2502.566,0.19932815114448; 2503.067,
            0.19673110860368; 2503.565,0.20062667241488; 2504.066,
            0.19828933412816; 2504.565,0.19828933412816; 2505.066,
            0.19880874263632; 2505.566,0.19595199584144; 2506.064,
            0.20010726390672; 2506.565,0.19958785539856; 2507.066,
            0.20088637666896; 2507.566,0.20088637666896; 2508.067,
            0.20140578517712; 2508.565,0.20270430644752; 2509.063,
            0.20244460219344; 2509.565,0.20400282771792; 2510.065,
            0.20218489793936; 2510.567,0.20711927876688; 2511.064,
            0.20504164473424; 2511.565,0.20634016600464; 2512.067,
            0.20634016600464; 2512.566,0.20452223622608; 2513.066,
            0.20582075749648; 2513.566,0.21231336384848; 2514.066,
            0.21049543406992; 2514.566,0.20867750429136; 2515.066,
            0.2094566170536; 2515.565,0.20841780003728; 2516.062,
            0.20841780003728; 2516.563,0.20867750429136; 2517.064,
            0.2055610532424; 2517.567,0.20478194048016; 2518.067,
            0.2068595745128; 2518.565,0.20348341920976; 2519.067,
            0.20452223622608; 2519.566,0.20270430644752; 2520.067,
            0.20244460219344; 2520.565,0.20270430644752; 2521.063,
            0.20218489793936; 2521.564,0.20244460219344; 2522.066,
            0.20452223622608; 2522.565,0.20478194048016; 2523.066,
            0.19958785539856; 2523.563,0.2029640107016; 2524.065,
            0.20114608092304; 2524.564,0.20322371495568; 2525.065,
            0.19880874263632; 2525.567,0.19828933412816; 2526.064,
            0.19984755965264; 2526.566,0.19621170009552; 2527.066,
            0.19828933412816; 2527.566,0.20062667241488; 2528.066,0.19776992562;
            2528.566,0.19854903838224; 2529.066,0.19880874263632; 2529.567,
            0.2016654894312; 2530.066,0.1990684468904; 2530.566,
            0.19854903838224; 2531.066,0.2003669681608; 2531.564,0.19776992562;
            2532.066,0.19932815114448; 2532.568,0.2003669681608; 2533.067,
            0.2003669681608; 2533.566,0.20192519368528; 2534.064,
            0.19880874263632; 2534.566,0.20192519368528; 2535.065,
            0.2016654894312; 2535.567,0.20140578517712; 2536.066,
            0.20140578517712; 2536.566,0.20218489793936; 2537.066,
            0.20088637666896; 2537.566,0.20322371495568; 2538.067,
            0.20218489793936; 2538.566,0.20010726390672; 2539.067,
            0.19932815114448; 2539.567,0.20140578517712; 2540.067,
            0.20348341920976; 2540.566,0.20062667241488; 2541.067,
            0.20192519368528; 2541.566,0.19984755965264; 2542.067,
            0.2016654894312; 2542.566,0.20062667241488; 2543.065,
            0.20010726390672; 2543.566,0.19854903838224; 2544.066,
            0.19984755965264; 2544.568,0.19673110860368; 2545.066,
            0.19880874263632; 2545.566,0.20010726390672; 2546.067,
            0.19854903838224; 2546.567,0.19854903838224; 2547.065,
            0.2003669681608; 2547.567,0.19543258733328; 2548.067,
            0.20140578517712; 2548.566,0.19725051711184; 2549.065,
            0.19725051711184; 2549.565,0.19491317882512; 2550.066,
            0.19854903838224; 2550.565,0.19569229158736; 2551.066,
            0.19699081285776; 2551.566,0.1964714043496; 2552.067,
            0.20010726390672; 2552.565,0.1964714043496; 2553.065,
            0.1990684468904; 2553.566,0.19854903838224; 2554.072,
            0.19854903838224],
        tableName="pump",
        fileName=
            "C:/Users/Fancy/OneDrive - University of Tennessee/Homework/Engineering/Nuclear/Research/INLDT/Experimental/Experimental Data/Dymola_Inputs/AVO_3H_PumpInput.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents)
        annotation (Placement(transformation(extent={{-104,12},{-84,32}})));
      Modelica.Blocks.Sources.CombiTimeTable BotValve(
        tableOnFile=false,
        table=[0,9.1350036144; 0.57,9.1103090736; 1.061,9.1391193712; 1.56,
            9.0979618032; 2.063,9.1926242096; 2.562,9.1596981552; 3.062,
            9.122656344; 3.562,9.163813912; 4.062,9.1185405872; 4.562,
            9.1350036144; 5.059,9.0897302896; 5.562,9.0362254512; 6.062,
            9.0238781808; 6.563,8.9539103152; 7.061,8.99918364; 7.563,
            8.978604856; 8.061,9.0074151536; 8.561,8.99918364; 9.061,
            9.0279939376; 9.562,8.9950678832; 10.061,9.0321096944; 10.562,
            9.0074151536; 11.061,9.081498776; 11.563,9.0732672624; 12.06,
            9.1185405872; 12.561,9.0938460464; 13.061,9.0156466672; 13.562,
            9.0444569648; 14.059,9.0568042352; 14.561,9.081498776; 15.061,
            9.0279939376; 15.562,9.0321096944; 16.06,9.0691515056; 16.559,
            9.0938460464; 17.062,9.0773830192; 17.562,9.1267721008; 18.062,
            9.0856145328; 18.56,9.10207756; 19.063,9.1185405872; 19.562,
            9.0979618032; 20.062,9.1720454256; 20.561,9.1761611824; 21.062,
            9.1885084528; 21.561,9.1473508848; 22.061,9.0485727216; 22.562,
            9.0485727216; 23.061,9.0732672624; 23.561,9.0691515056; 24.062,
            9.0238781808; 24.561,9.040341208; 25.063,9.0115309104; 25.561,
            9.081498776; 26.062,9.1144248304; 26.561,9.1267721008; 27.062,
            9.1802769392; 27.562,9.1391193712; 28.061,9.20497148; 28.562,
            9.1308878576; 29.062,9.10207756; 29.563,9.184392696; 30.062,
            9.163813912; 30.562,9.1555823984; 31.062,9.122656344; 31.563,
            9.184392696; 32.061,9.20497148; 32.559,9.1761611824; 33.063,
            9.1391193712; 33.56,9.122656344; 34.06,9.0691515056; 34.561,
            9.0938460464; 35.061,9.1144248304; 35.56,9.1267721008; 36.062,
            9.1391193712; 36.562,9.1061933168; 37.061,9.0856145328; 37.562,
            9.10207756; 38.061,9.0691515056; 38.56,9.0938460464; 39.06,
            9.0938460464; 39.563,9.0238781808; 40.061,9.0691515056; 40.562,
            9.1350036144; 41.061,9.0856145328; 41.561,9.040341208; 42.063,
            9.0526884784; 42.56,8.99918364; 43.061,9.0526884784; 43.558,
            9.0732672624; 44.061,9.1391193712; 44.562,8.9909521264; 45.062,
            9.019762424; 45.56,9.0238781808; 46.064,9.0156466672; 46.562,
            9.0485727216; 47.06,9.0773830192; 47.56,9.0732672624; 48.061,
            9.1267721008; 48.561,9.1885084528; 49.061,9.1926242096; 49.561,
            9.1720454256; 50.061,9.1391193712; 50.561,9.1350036144; 51.062,
            9.143235128; 51.56,9.1473508848; 52.061,9.1185405872; 52.561,
            9.1185405872; 53.062,9.1185405872; 53.562,9.0732672624; 54.058,
            9.1144248304; 54.56,9.0938460464; 55.06,9.1514666416; 55.561,
            9.122656344; 56.062,9.1308878576; 56.562,9.1185405872; 57.061,
            9.184392696; 57.561,9.2337817776; 58.061,9.20497148; 58.559,
            9.225550264; 59.058,9.2584763184; 59.558,9.266707832; 60.058,
            9.2132029936; 60.559,9.1267721008; 61.06,9.1144248304; 61.56,
            9.0856145328; 62.061,9.0773830192; 62.56,8.99918364; 63.058,
            9.0156466672; 63.56,9.0032993968; 64.059,9.019762424; 64.559,
            9.0321096944; 65.063,9.0526884784; 65.561,9.0444569648; 66.062,
            9.0773830192; 66.561,9.040341208; 67.061,9.0526884784; 67.562,
            9.0938460464; 68.062,9.081498776; 68.561,9.1103090736; 69.062,
            9.1308878576; 69.562,9.1514666416; 70.061,9.1391193712; 70.561,
            9.1555823984; 71.061,9.0938460464; 71.561,9.1308878576; 72.061,
            9.1061933168; 72.558,9.1185405872; 73.062,9.1473508848; 73.562,
            9.1720454256; 74.062,9.1967399664; 74.561,9.2008557232; 75.062,
            9.1185405872; 75.561,9.1679296688; 76.061,9.1185405872; 76.562,
            9.1555823984; 77.062,9.1350036144; 77.562,9.1391193712; 78.062,
            9.1308878576; 78.563,9.143235128; 79.061,9.1473508848; 79.56,
            9.1185405872; 80.061,9.1267721008; 80.561,9.0279939376; 81.062,
            9.0321096944; 81.561,9.0444569648; 82.061,9.1761611824; 82.561,
            9.1802769392; 83.061,9.1720454256; 83.562,9.1761611824; 84.06,
            9.2132029936; 84.56,9.1596981552; 85.063,9.1596981552; 85.562,
            9.1473508848; 86.062,9.1679296688; 86.561,9.1926242096; 87.062,
            9.2214345072; 87.561,9.2625920752; 88.062,9.2296660208; 88.561,
            9.2132029936; 89.061,9.20497148; 89.562,9.2502448048; 90.062,
            9.2337817776; 90.562,9.225550264; 91.061,9.1761611824; 91.561,
            9.2008557232; 92.061,9.184392696; 92.561,9.1802769392; 93.061,
            9.1761611824; 93.56,9.1761611824; 94.061,9.122656344; 94.561,
            9.1185405872; 95.061,9.1555823984; 95.561,9.1103090736; 96.071,
            9.0238781808; 96.561,9.0279939376; 97.063,9.0856145328; 97.562,
            9.1350036144; 98.062,9.1308878576; 98.561,9.0773830192; 99.062,
            9.1061933168; 99.562,9.0732672624; 100.063,9.143235128; 100.563,
            9.0732672624; 101.061,9.0856145328; 101.562,9.0979618032; 102.062,
            9.1185405872; 102.561,9.0773830192; 103.061,9.0568042352; 103.563,
            9.1103090736; 104.063,9.0568042352; 104.562,9.0732672624; 105.091,
            9.1144248304; 105.559,9.1267721008; 106.061,9.0979618032; 106.56,
            9.060919992; 107.061,9.060919992; 107.56,8.9909521264; 108.062,
            9.0568042352; 108.561,9.0444569648; 109.061,9.0526884784; 109.561,
            9.0979618032; 110.062,9.0732672624; 110.561,9.060919992; 111.061,
            9.10207756; 111.561,9.122656344; 112.06,9.0856145328; 112.562,
            9.1061933168; 113.059,9.1350036144; 113.562,9.060919992; 114.062,
            9.0773830192; 114.561,9.1061933168; 115.063,9.1761611824; 115.562,
            9.1720454256; 116.063,9.1679296688; 116.561,9.2173187504; 117.063,
            9.1720454256; 117.562,9.184392696; 118.061,9.1885084528; 118.561,
            9.1802769392; 119.062,9.184392696; 119.563,9.163813912; 120.062,
            9.1267721008; 120.563,9.1103090736; 121.061,9.1473508848; 121.562,
            9.2090872368; 122.061,9.1802769392; 122.562,9.163813912; 123.063,
            9.184392696; 123.562,9.1555823984; 124.063,9.143235128; 124.563,
            9.1350036144; 125.062,9.143235128; 125.561,9.1555823984; 126.062,
            9.1391193712; 126.56,9.184392696; 127.061,9.1885084528; 127.564,
            9.1761611824; 128.063,9.1267721008; 128.563,9.0444569648; 129.075,
            9.0650357488; 129.562,9.0279939376; 130.061,8.9909521264; 130.56,
            9.0568042352; 131.063,9.1103090736; 131.561,9.1350036144; 132.06,
            9.1061933168; 132.561,9.1596981552; 133.06,9.1473508848; 133.56,
            9.143235128; 134.062,9.1596981552; 134.561,9.163813912; 135.06,
            9.1555823984; 135.562,9.1391193712; 136.062,9.1555823984; 136.559,
            9.1802769392; 137.059,9.1514666416; 137.559,9.2008557232; 138.07,
            9.163813912; 138.56,9.122656344; 139.062,9.1308878576; 139.558,
            9.1103090736; 140.061,9.081498776; 140.561,9.1144248304; 141.06,
            9.1061933168; 141.562,9.10207756; 142.062,9.081498776; 142.562,
            9.0691515056; 143.061,9.0568042352; 143.562,8.9868363696; 144.062,
            9.0279939376; 144.562,9.0362254512; 145.06,9.0691515056; 145.562,
            9.0897302896; 146.062,9.081498776; 146.558,9.0979618032; 147.064,
            9.0650357488; 147.562,9.081498776; 148.06,9.081498776; 148.562,
            9.0568042352; 149.062,9.122656344; 149.562,9.0732672624; 150.062,
            9.1267721008; 150.562,9.0897302896; 151.06,9.0444569648; 151.563,
            9.0032993968; 152.062,9.0279939376; 152.561,9.0156466672; 153.064,
            9.040341208; 153.562,9.060919992; 154.062,9.0526884784; 154.562,
            9.1267721008; 155.059,9.1473508848; 155.562,9.1885084528; 156.061,
            9.2625920752; 156.56,9.246129048; 157.063,9.3037496432; 157.563,
            9.246129048; 158.061,9.2378975344; 158.563,9.2502448048; 159.061,
            9.225550264; 159.56,9.20497148; 160.062,9.1885084528; 160.562,
            9.1926242096; 161.062,9.1267721008; 161.558,9.1679296688; 162.062,
            9.10207756; 162.567,9.1144248304; 163.061,9.1802769392; 163.561,
            9.1350036144; 164.061,9.1267721008; 164.559,9.1514666416; 165.06,
            9.0979618032; 165.558,9.143235128; 166.059,9.1391193712; 166.559,
            9.1761611824; 167.059,9.060919992; 167.559,9.1391193712; 168.062,
            9.1185405872; 168.558,9.1103090736; 169.06,9.1185405872; 169.562,
            9.143235128; 170.062,9.1391193712; 170.561,9.143235128; 171.065,
            9.1473508848; 171.559,9.1514666416; 172.062,9.1761611824; 172.56,
            9.1802769392; 173.059,9.1967399664; 173.56,9.1926242096; 174.06,
            9.1802769392; 174.56,9.1514666416; 175.059,9.1885084528; 175.559,
            9.1679296688; 176.062,9.1514666416; 176.56,9.1061933168; 177.061,
            9.1308878576; 177.561,9.0979618032; 178.06,9.060919992; 178.558,
            9.081498776; 179.06,9.1350036144; 179.559,9.0979618032; 180.06,
            9.081498776; 180.561,9.081498776; 181.061,9.081498776; 181.559,
            9.1061933168; 182.061,9.1103090736; 182.56,9.1144248304; 183.062,
            9.1391193712; 183.562,9.143235128; 184.06,9.10207756; 184.563,
            9.1308878576; 185.061,9.143235128; 185.562,9.1308878576; 186.059,
            9.1103090736; 186.559,9.1555823984; 187.062,9.1308878576; 187.562,
            9.1514666416; 188.061,9.1967399664; 188.559,9.1761611824; 189.061,
            9.2420132912; 189.561,9.1885084528; 190.062,9.1885084528; 190.561,
            9.163813912; 191.062,9.1885084528; 191.558,9.1926242096; 192.06,
            9.0897302896; 192.559,9.0650357488; 193.062,9.1350036144; 193.561,
            9.0691515056; 194.062,8.9909521264; 194.562,9.0568042352; 195.062,
            9.0485727216; 195.562,9.060919992; 196.058,9.0691515056; 196.558,
            9.10207756; 197.061,9.0938460464; 197.561,9.0732672624; 198.062,
            9.122656344; 198.563,9.0568042352; 199.061,9.10207756; 199.561,
            9.0938460464; 200.062,9.0732672624; 200.559,9.1473508848; 201.062,
            9.0897302896; 201.559,9.163813912; 202.062,9.143235128; 202.561,
            9.1596981552; 203.062,9.143235128; 203.563,9.143235128; 204.061,
            9.1144248304; 204.563,9.1926242096; 205.062,9.1308878576; 205.562,
            9.1473508848; 206.061,9.1350036144; 206.56,9.1144248304; 207.06,
            9.143235128; 207.562,9.1391193712; 208.062,9.0979618032; 208.559,
            9.0938460464; 209.062,9.0773830192; 209.562,9.0732672624; 210.061,
            9.0897302896; 210.562,9.1103090736; 211.063,9.143235128; 211.562,
            9.10207756; 212.062,9.1885084528; 212.562,9.122656344; 213.062,
            9.1514666416; 213.561,9.143235128; 214.061,9.1473508848; 214.559,
            9.1926242096; 215.062,9.2090872368; 215.562,9.2008557232; 216.061,
            9.1967399664; 216.563,9.2584763184; 217.059,9.2543605616; 217.562,
            9.2543605616; 218.062,9.2378975344; 218.563,9.1761611824; 219.063,
            9.163813912; 219.56,9.1967399664; 220.062,9.2090872368; 220.562,
            9.20497148; 221.061,9.225550264; 221.563,9.2296660208; 222.061,
            9.2132029936; 222.562,9.2090872368; 223.061,9.1885084528; 223.562,
            9.2008557232; 224.061,9.2173187504; 224.56,9.2173187504; 225.063,
            9.2173187504; 225.562,9.1596981552; 226.062,9.143235128; 226.56,
            9.122656344; 227.061,9.1679296688; 227.561,9.163813912; 228.062,
            9.2337817776; 228.561,9.246129048; 229.059,9.2214345072; 229.561,
            9.246129048; 230.062,9.246129048; 230.561,9.246129048; 231.062,
            9.2132029936; 231.56,9.1967399664; 232.062,9.1802769392; 232.563,
            9.163813912; 233.06,9.1802769392; 233.562,9.184392696; 234.06,
            9.1926242096; 234.56,9.1802769392; 235.06,9.184392696; 235.561,
            9.1761611824; 236.062,9.1679296688; 236.561,9.184392696; 237.062,
            9.1555823984; 237.561,9.1596981552; 238.061,9.1885084528; 238.562,
            9.1473508848; 239.062,9.163813912; 239.559,9.1267721008; 240.061,
            9.1596981552; 240.559,9.1761611824; 241.061,9.184392696; 241.559,
            9.1761611824; 242.061,9.1967399664; 242.558,9.2296660208; 243.062,
            9.2132029936; 243.562,9.2214345072; 244.061,9.20497148; 244.561,
            9.2090872368; 245.061,9.246129048; 245.559,9.2337817776; 246.061,
            9.2543605616; 246.56,9.2914023728; 247.062,9.2502448048; 247.561,
            9.266707832; 248.059,9.2337817776; 248.561,9.2584763184; 249.06,
            9.2378975344; 249.562,9.1926242096; 250.063,9.2337817776; 250.561,
            9.1885084528; 251.06,9.1926242096; 251.561,9.2132029936; 252.06,
            9.1720454256; 252.562,9.163813912; 253.06,9.1679296688; 253.561,
            9.1308878576; 254.062,9.1473508848; 254.562,9.1308878576; 255.058,
            9.1679296688; 255.562,9.20908723680001; 256.063,9.1679296688;
            256.562,9.2337817776; 257.061,9.2378975344; 257.563,9.2296660208;
            258.059,9.2296660208; 258.567,9.2173187504; 259.062,9.2337817776;
            259.562,9.2296660208; 260.063,9.2584763184; 260.558,9.2337817776;
            261.058,9.2749393456; 261.559,9.246129048; 262.059,9.2420132912;
            262.56,9.2502448048; 263.059,9.266707832; 263.559,9.2955181296;
            264.062,9.2378975344; 264.559,9.2214345072; 265.059,9.2296660208;
            265.562,9.246129048; 266.062,9.1473508848; 266.562,9.1967399664;
            267.06,9.1350036144; 267.563,9.1885084528; 268.062,9.1061933168;
            268.561,9.1514666416; 269.061,9.1555823984; 269.561,9.1555823984;
            270.062,9.1473508848; 270.561,9.163813912; 271.062,9.1391193712;
            271.562,9.1185405872; 272.062,9.122656344; 272.562,9.143235128;
            273.062,9.1103090736; 273.562,9.1802769392; 274.063,9.1596981552;
            274.562,9.1514666416; 275.062,9.1391193712; 275.563,9.0979618032;
            276.064,9.1596981552; 276.559,9.1514666416; 277.062,9.1967399664;
            277.561,9.1926242096; 278.061,9.1802769392; 278.563,9.184392696;
            279.062,9.1720454256; 279.561,9.163813912; 280.062,9.1720454256;
            280.562,9.1720454256; 281.061,9.1596981552; 281.559,9.1679296688;
            282.062,9.1802769392; 282.561,9.1555823984; 283.062,9.1679296688;
            283.563,9.1885084528; 284.059,9.1514666416; 284.562,9.1761611824;
            285.061,9.20497148; 285.561,9.2420132912; 286.062,9.225550264;
            286.56,9.2584763184; 287.061,9.2790551024; 287.559,9.2214345072;
            288.062,9.2173187504; 288.562,9.184392696; 289.062,9.2543605616;
            289.564,9.2625920752; 290.062,9.225550264; 290.563,9.1926242096;
            291.059,9.122656344; 291.559,9.122656344; 292.062,9.1761611824;
            292.563,9.266707832; 293.062,9.2790551024; 293.563,9.1596981552;
            294.062,9.1720454256; 294.559,9.122656344; 295.063,9.1308878576;
            295.561,9.1267721008; 296.061,9.1596981552; 296.561,9.20497148;
            297.061,9.1596981552; 297.563,9.2132029936; 298.061,9.2008557232;
            298.561,9.2214345072; 299.061,9.2008557232; 299.559,9.225550264;
            300.063,9.1885084528; 300.561,9.2008557232; 301.061,9.2008557232;
            301.564,9.225550264; 302.061,9.1967399664; 302.562,9.2090872368;
            303.063,9.2502448048; 303.562,9.2090872368; 304.062,9.2296660208;
            304.562,9.225550264; 305.062,9.2173187504; 305.561,9.2378975344;
            306.063,9.1761611824; 306.563,9.2337817776; 307.064,9.2214345072;
            307.561,9.2008557232; 308.061,9.246129048; 308.564,9.2214345072;
            309.063,9.2378975344; 309.563,9.246129048; 310.061,9.2584763184;
            310.561,9.2296660208; 311.062,9.225550264; 311.562,9.2337817776;
            312.062,9.225550264; 312.561,9.2296660208; 313.06,9.2173187504;
            313.562,9.2214345072; 314.062,9.2008557232; 314.562,9.2214345072;
            315.062,9.20497148; 315.561,9.1802769392; 316.062,9.266707832;
            316.562,9.2337817776; 317.062,9.2543605616; 317.56,9.2502448048;
            318.063,9.2296660208; 318.561,9.2502448048; 319.064,9.1967399664;
            319.561,9.2090872368; 320.063,9.2420132912; 320.561,9.2214345072;
            321.062,9.246129048; 321.563,9.2090872368; 322.062,9.1926242096;
            322.56,9.225550264; 323.062,9.2090872368; 323.563,9.225550264;
            324.064,9.2584763184; 324.562,9.2420132912; 325.063,9.3037496432;
            325.561,9.2625920752; 326.064,9.2625920752; 326.563,9.2214345072;
            327.062,9.2420132912; 327.563,9.2708235888; 328.063,9.2955181296;
            328.561,9.287286616; 329.061,9.2914023728; 329.561,9.2584763184;
            330.061,9.2214345072; 330.563,9.225550264; 331.061,9.1802769392;
            331.563,9.2008557232; 332.064,9.2749393456; 332.562,9.2749393456;
            333.062,9.2543605616; 333.561,9.3037496432; 334.062,9.2625920752;
            334.561,9.3119811568; 335.062,9.2914023728; 335.562,9.3243284272;
            336.063,9.2996338864; 336.562,9.3325599408; 337.062,9.390180536;
            337.562,9.41075932; 338.062,9.3942962928; 338.561,9.41075932;
            339.062,9.3531387248; 339.563,9.3243284272; 340.063,9.2955181296;
            340.563,9.2831708592; 341.063,9.2543605616; 341.558,9.2337817776;
            342.06,9.2378975344; 342.561,9.2296660208; 343.061,9.2502448048;
            343.563,9.246129048; 344.06,9.2296660208; 344.564,9.2090872368;
            345.063,9.2831708592; 345.563,9.266707832; 346.059,9.3160969136;
            346.562,9.287286616; 347.062,9.328444184; 347.562,9.3243284272;
            348.062,9.3119811568; 348.563,9.3243284272; 349.062,9.3572544816;
            349.563,9.3449072112; 350.063,9.3737175088; 350.562,9.3613702384;
            351.062,9.3078654; 351.561,9.3037496432; 352.062,9.2790551024;
            352.561,9.2378975344; 353.061,9.2337817776; 353.562,9.2584763184;
            354.062,9.2955181296; 354.562,9.3202126704; 355.062,9.3037496432;
            355.563,9.328444184; 356.062,9.3202126704; 356.56,9.3449072112;
            357.062,9.3654859952; 357.561,9.3984120496; 358.062,9.369601752;
            358.561,9.287286616; 359.064,9.2749393456; 359.561,9.3613702384;
            360.062,9.2996338864; 360.562,9.2914023728; 361.059,9.2625920752;
            361.564,9.246129048; 362.063,9.3202126704; 362.558,9.2831708592;
            363.061,9.225550264; 363.563,9.2914023728; 364.062,9.2132029936;
            364.561,9.2543605616; 365.061,9.266707832; 365.56,9.2708235888;
            366.063,9.2831708592; 366.56,9.2584763184; 367.062,9.2502448048;
            367.562,9.2708235888; 368.062,9.2996338864; 368.562,9.2708235888;
            369.063,9.2914023728; 369.558,9.3160969136; 370.061,9.3078654;
            370.563,9.3325599408; 371.063,9.3037496432; 371.561,9.3037496432;
            372.064,9.3654859952; 372.561,9.349022968; 373.062,9.328444184;
            373.563,9.2831708592; 374.061,9.2584763184; 374.561,9.3119811568;
            375.061,9.2996338864; 375.562,9.3119811568; 376.063,9.2955181296;
            376.562,9.3531387248; 377.061,9.2996338864; 377.561,9.3366756976;
            378.061,9.3119811568; 378.561,9.3613702384; 379.062,9.3325599408;
            379.562,9.3572544816; 380.062,9.3654859952; 380.561,9.3737175088;
            381.063,9.2914023728; 381.563,9.3119811568; 382.062,9.3078654;
            382.564,9.3202126704; 383.062,9.287286616; 383.561,9.3037496432;
            384.062,9.3202126704; 384.562,9.3531387248; 385.062,9.3160969136;
            385.564,9.3942962928; 386.062,9.3531387248; 386.562,9.4025278064;
            387.062,9.4395696176; 387.562,9.4025278064; 388.063,9.4272223472;
            388.563,9.3860647792; 389.063,9.3449072112; 389.562,9.3325599408;
            390.063,9.3366756976; 390.562,9.287286616; 391.064,9.3243284272;
            391.562,9.3119811568; 392.063,9.2132029936; 392.561,9.2008557232;
            393.063,9.2584763184; 393.563,9.20497148; 394.064,9.2420132912;
            394.563,9.2214345072; 395.062,9.20497148; 395.563,9.1967399664;
            396.064,9.225550264; 396.563,9.2008557232; 397.062,9.266707832;
            397.562,9.2955181296; 398.062,9.287286616; 398.564,9.3202126704;
            399.061,9.2996338864; 399.562,9.3037496432; 400.063,9.2708235888;
            400.563,9.2790551024; 401.062,9.2749393456; 401.559,9.2996338864;
            402.063,9.3160969136; 402.561,9.3243284272; 403.062,9.3243284272;
            403.56,9.2378975344; 404.061,9.2749393456; 404.562,9.2708235888;
            405.062,9.2173187504; 405.563,9.2749393456; 406.059,9.2584763184;
            406.562,9.3119811568; 407.062,9.2749393456; 407.559,9.2831708592;
            408.062,9.3160969136; 408.562,9.287286616; 409.062,9.3243284272;
            409.562,9.3243284272; 410.062,9.3778332656; 410.562,9.3654859952;
            411.062,9.3819490224; 411.563,9.3407914544; 412.063,9.3819490224;
            412.563,9.369601752; 413.062,9.3572544816; 413.562,9.3860647792;
            414.062,9.4189908336; 414.562,9.3613702384; 415.061,9.3778332656;
            415.562,9.3531387248; 416.062,9.3737175088; 416.562,9.3449072112;
            417.06,9.390180536; 417.561,9.3325599408; 418.058,9.3243284272;
            418.561,9.3243284272; 419.063,9.266707832; 419.563,9.3160969136;
            420.062,9.3325599408; 420.563,9.3119811568; 421.064,9.3325599408;
            421.563,9.3984120496; 422.06,9.41075932; 422.562,9.3572544816;
            423.059,9.3778332656; 423.562,9.4066435632; 424.064,9.390180536;
            424.562,9.3654859952; 425.062,9.2996338864; 425.563,9.3119811568;
            426.062,9.3078654; 426.562,9.3572544816; 427.06,9.4025278064;
            427.564,9.3654859952; 428.061,9.2955181296; 428.561,9.3325599408;
            429.063,9.3366756976; 429.561,9.3654859952; 430.062,9.3819490224;
            430.561,9.349022968; 431.062,9.3572544816; 431.562,9.3613702384;
            432.058,9.3449072112; 432.564,9.3366756976; 433.064,9.328444184;
            433.563,9.3531387248; 434.062,9.3407914544; 434.563,9.3737175088;
            435.062,9.349022968; 435.563,9.328444184; 436.061,9.369601752;
            436.562,9.2996338864; 437.059,9.3572544816; 437.56,9.3325599408;
            438.193,9.3572544816; 438.559,9.3449072112; 439.062,9.3778332656;
            439.563,9.390180536; 440.074,9.3572544816; 440.561,9.3860647792;
            441.06,9.3778332656; 441.563,9.3613702384; 442.061,9.3366756976;
            442.562,9.3654859952; 443.064,9.3737175088; 443.561,9.3778332656;
            444.064,9.3778332656; 444.563,9.3860647792; 445.075,9.3202126704;
            445.573,9.328444184; 446.063,9.2996338864; 446.582,9.369601752;
            447.061,9.3778332656; 447.564,9.4395696176; 448.064,9.4189908336;
            448.562,9.3984120496; 449.062,9.349022968; 449.559,9.3531387248;
            450.059,9.3531387248; 450.563,9.3202126704; 451.062,9.3449072112;
            451.563,9.2708235888; 452.059,9.3572544816; 452.564,9.3160969136;
            453.06,9.2955181296; 453.561,9.2955181296; 454.06,9.3366756976;
            454.56,9.3325599408; 455.06,9.3572544816; 455.558,9.3572544816;
            456.06,9.4025278064; 456.562,9.3942962928; 457.059,9.390180536;
            457.564,9.4148750768; 458.061,9.472495672; 458.561,9.472495672;
            459.06,9.4683799152; 459.562,9.4560326448; 460.06,9.4889586992;
            460.56,9.451916888; 461.062,9.3819490224; 461.562,9.4272223472;
            462.066,9.287286616; 462.569,9.2996338864; 463.06,9.3160969136;
            463.562,9.2914023728; 464.063,9.3037496432; 464.561,9.3654859952;
            465.06,9.3407914544; 465.563,9.3160969136; 466.06,9.3160969136;
            466.562,9.287286616; 467.061,9.266707832; 467.563,9.2996338864;
            468.062,9.3078654; 468.564,9.3078654; 469.064,9.3819490224; 469.563,
            9.3654859952; 470.063,9.3737175088; 470.562,9.3737175088; 471.062,
            9.4231065904; 471.563,9.4436853744; 472.06,9.431338104; 472.563,
            9.390180536; 473.06,9.4025278064; 473.563,9.3737175088; 474.063,
            9.3613702384; 474.559,9.390180536; 475.062,9.3654859952; 475.563,
            9.4189908336; 476.062,9.369601752; 476.562,9.4148750768; 477.06,
            9.41075932; 477.562,9.41075932; 478.062,9.4066435632; 478.562,
            9.4148750768; 479.061,9.4025278064; 479.562,9.369601752; 480.064,
            9.4066435632; 480.563,9.3984120496; 481.061,9.4189908336; 481.563,
            9.4231065904; 482.061,9.3572544816; 482.563,9.3407914544; 483.062,
            9.3202126704; 483.562,9.3243284272; 484.061,9.3037496432; 484.563,
            9.3366756976; 485.061,9.3654859952; 485.562,9.4148750768; 486.061,
            9.3984120496; 486.561,9.4231065904; 487.062,9.4189908336; 487.562,
            9.4272223472; 488.061,9.4148750768; 488.563,9.41075932; 489.063,
            9.3860647792; 489.563,9.3942962928; 490.062,9.3860647792; 490.563,
            9.4848429424; 491.063,9.4478011312; 491.562,9.4148750768; 492.061,
            9.4436853744; 492.562,9.4066435632; 493.062,9.4272223472; 493.562,
            9.431338104; 494.061,9.431338104; 494.562,9.3819490224; 495.062,
            9.390180536; 495.562,9.3449072112; 496.062,9.349022968; 496.563,
            9.349022968; 497.063,9.3737175088; 497.561,9.3449072112; 498.063,
            9.3613702384; 498.563,9.4066435632; 499.063,9.3860647792; 499.562,
            9.3942962928; 500.062,9.390180536; 500.561,9.3407914544; 501.063,
            9.3531387248; 501.563,9.3160969136; 502.062,9.3366756976; 502.562,
            9.3531387248; 503.061,9.3407914544; 503.563,9.3860647792; 504.063,
            9.3860647792; 504.562,9.4231065904; 505.062,9.3778332656; 505.565,
            9.3860647792; 506.062,9.3613702384; 506.563,9.390180536; 507.06,
            9.4189908336; 507.562,9.349022968; 508.064,9.3778332656; 508.564,
            9.4395696176; 509.061,9.4231065904; 509.562,9.3942962928; 510.059,
            9.369601752; 510.563,9.41075932; 511.062,9.3819490224; 511.56,
            9.3778332656; 512.062,9.431338104; 512.561,9.4189908336; 513.061,
            9.431338104; 513.564,9.4189908336; 514.059,9.4971902128; 514.562,
            9.4601484016; 515.059,9.493074456; 515.564,9.4560326448; 516.064,
            9.328444184; 516.563,9.3449072112; 517.06,9.3366756976; 517.562,
            9.2996338864; 518.062,9.328444184; 518.562,9.3160969136; 519.062,
            9.3737175088; 519.562,9.3160969136; 520.062,9.3202126704; 520.564,
            9.3613702384; 521.062,9.4642641584; 521.563,9.4272223472; 522.061,
            9.431338104; 522.562,9.4395696176; 523.06,9.4766114288; 523.563,
            9.5095374832; 524.063,9.493074456; 524.561,9.4971902128; 525.062,
            9.4683799152; 525.562,9.431338104; 526.062,9.3531387248; 526.561,
            9.3366756976; 527.063,9.2955181296; 527.562,9.3449072112; 528.06,
            9.3737175088; 528.574,9.431338104; 529.061,9.349022968; 529.562,
            9.3984120496; 530.063,9.3778332656; 530.562,9.4189908336; 531.061,
            9.4395696176; 531.562,9.4642641584; 532.064,9.4683799152; 532.561,
            9.4231065904; 533.063,9.4189908336; 533.558,9.4025278064; 534.063,
            9.4272223472; 534.561,9.390180536; 535.061,9.3942962928; 535.563,
            9.3819490224; 536.062,9.390180536; 536.563,9.3449072112; 537.062,
            9.390180536; 537.561,9.3860647792; 538.061,9.3860647792; 538.559,
            9.4148750768; 539.064,9.3984120496; 539.561,9.4189908336; 540.061,
            9.3819490224; 540.562,9.3613702384; 541.063,9.3860647792; 541.563,
            9.390180536; 542.063,9.4231065904; 542.562,9.3778332656; 543.064,
            9.4148750768; 543.561,9.3449072112; 544.063,9.3819490224; 544.561,
            9.4683799152; 545.062,9.431338104; 545.562,9.4436853744; 546.061,
            9.41075932; 546.563,9.4807271856; 547.061,9.41075932; 547.561,
            9.3942962928; 548.062,9.4436853744; 548.562,9.4354538608; 549.062,
            9.4231065904; 549.564,9.4231065904; 550.062,9.41075932; 550.561,
            9.369601752; 551.062,9.369601752; 551.561,9.390180536; 552.063,
            9.3449072112; 552.56,9.4478011312; 553.063,9.4272223472; 553.562,
            9.3942962928; 554.062,9.4642641584; 554.562,9.41075932; 555.062,
            9.3942962928; 555.562,9.390180536; 556.063,9.4231065904; 556.563,
            9.431338104; 557.064,9.472495672; 557.561,9.4601484016; 558.059,
            9.4848429424; 558.563,9.5671580784; 559.06,9.5506950512; 559.563,
            9.5095374832; 560.062,9.4683799152; 560.563,9.3737175088; 561.063,
            9.3572544816; 561.56,9.390180536; 562.177,9.4066435632; 562.563,
            9.3572544816; 563.062,9.349022968; 563.562,9.3737175088; 564.062,
            9.4066435632; 564.562,9.4025278064; 565.062,9.3613702384; 565.563,
            9.4066435632; 566.063,9.3737175088; 566.563,9.4066435632; 567.061,
            9.4066435632; 567.563,9.4272223472; 568.064,9.4066435632; 568.562,
            9.4272223472; 569.063,9.4066435632; 569.563,9.4189908336; 570.062,
            9.4272223472; 570.562,9.3984120496; 571.062,9.4354538608; 571.564,
            9.4354538608; 572.062,9.451916888; 572.563,9.451916888; 573.062,
            9.4395696176; 573.561,9.4395696176; 574.059,9.5054217264; 574.564,
            9.431338104; 575.063,9.4189908336; 575.561,9.3984120496; 576.06,
            9.3860647792; 576.56,9.3613702384; 577.06,9.4889586992; 577.56,
            9.4272223472; 578.058,9.4560326448; 578.56,9.4642641584; 579.06,
            9.4560326448; 579.559,9.3860647792; 580.063,9.349022968; 580.563,
            9.349022968; 581.063,9.3860647792; 581.56,9.3942962928; 582.062,
            9.4807271856; 582.562,9.5095374832; 583.062,9.4766114288; 583.563,
            9.4766114288; 584.061,9.4601484016; 584.562,9.451916888; 585.062,
            9.4354538608; 585.563,9.4478011312; 586.061,9.4766114288; 586.564,
            9.4272223472; 587.062,9.4148750768; 587.561,9.4231065904; 588.061,
            9.4231065904; 588.562,9.4189908336; 589.062,9.4478011312; 589.562,
            9.41075932; 590.063,9.4354538608; 590.563,9.4066435632; 591.063,
            9.3737175088; 591.562,9.4148750768; 592.063,9.3942962928; 592.562,
            9.3819490224; 593.063,9.3860647792; 593.562,9.369601752; 594.063,
            9.4272223472; 594.563,9.431338104; 595.063,9.4395696176; 595.56,
            9.451916888; 596.062,9.4189908336; 596.563,9.4189908336; 597.063,
            9.4066435632; 597.562,9.4560326448; 598.06,9.4395696176; 598.562,
            9.4971902128; 599.063,9.4642641584; 599.562,9.451916888; 600.064,
            9.4189908336; 600.562,9.431338104; 601.062,9.390180536; 601.561,
            9.4560326448; 602.062,9.4025278064; 602.563,9.431338104; 603.062,
            9.4231065904; 603.561,9.4683799152; 604.064,9.4231065904; 604.562,
            9.431338104; 605.061,9.4231065904; 605.564,9.4436853744; 606.063,
            9.4683799152; 606.563,9.4560326448; 607.063,9.4601484016; 607.562,
            9.5177689968; 608.063,9.4189908336; 608.561,9.4189908336; 609.061,
            9.4231065904; 609.564,9.3860647792; 610.062,9.451916888; 610.563,
            9.451916888; 611.062,9.3984120496; 611.562,9.4189908336; 612.062,
            9.390180536; 612.563,9.3737175088; 613.061,9.3572544816; 613.562,
            9.3737175088; 614.064,9.4025278064; 614.563,9.4272223472; 615.062,
            9.4025278064; 615.562,9.4354538608; 616.062,9.41075932; 616.563,
            9.4560326448; 617.063,9.4436853744; 617.564,9.4395696176; 618.061,
            9.5301162672; 618.561,9.493074456; 619.062,9.4683799152; 619.563,
            9.4231065904; 620.063,9.4766114288; 620.56,9.4148750768; 621.063,
            9.4395696176; 621.56,9.4642641584; 622.061,9.390180536; 622.562,
            9.4601484016; 623.06,9.390180536; 623.562,9.4066435632; 624.063,
            9.4560326448; 624.56,9.4478011312; 625.063,9.3819490224; 625.563,
            9.4272223472; 626.064,9.451916888; 626.563,9.4231065904; 627.062,
            9.328444184; 627.563,9.390180536; 628.062,9.4766114288; 628.562,
            9.5177689968; 629.062,9.4642641584; 629.561,9.5424635376; 630.062,
            9.5671580784; 630.563,9.5177689968; 631.062,9.4848429424; 631.561,
            9.575389592; 632.062,9.5054217264; 632.561,9.5795053488; 633.062,
            9.554810808; 633.562,9.472495672; 634.06,9.5013059696; 634.562,
            9.431338104; 635.058,9.4889586992; 635.562,9.4807271856; 636.062,
            9.41075932; 636.559,9.4272223472; 637.06,9.41075932; 637.562,
            9.3654859952; 638.062,9.369601752; 638.562,9.4189908336; 639.063,
            9.4231065904; 639.562,9.4354538608; 640.062,9.4148750768; 640.563,
            9.4642641584; 641.063,9.4642641584; 641.564,9.5177689968; 642.063,
            9.4848429424; 642.562,9.5260005104; 643.06,9.5218847536; 643.562,
            9.5095374832; 644.062,9.4683799152; 644.561,9.4971902128; 645.064,
            9.5054217264; 645.563,9.4889586992; 646.062,9.5383477808; 646.564,
            9.5424635376; 647.063,9.534232024; 647.56,9.5506950512; 648.063,
            9.5877368624; 648.562,9.5260005104; 649.063,9.5013059696; 649.562,
            9.4807271856; 650.063,9.4189908336; 650.559,9.4231065904; 651.062,
            9.3778332656; 651.559,9.369601752; 652.06,9.3819490224; 652.563,
            9.4148750768; 653.062,9.4766114288; 653.564,9.5013059696; 654.062,
            9.5095374832; 654.563,9.5095374832; 655.062,9.5013059696; 655.562,
            9.390180536; 656.06,9.451916888; 656.563,9.390180536; 657.063,
            9.4272223472; 657.561,9.3984120496; 658.062,9.3942962928; 658.559,
            9.3984120496; 659.06,9.4066435632; 659.559,9.4272223472; 660.06,
            9.4560326448; 660.561,9.3819490224; 661.06,9.4560326448; 661.56,
            9.3860647792; 662.059,9.41075932; 662.564,9.4354538608; 663.064,
            9.4066435632; 663.56,9.41075932; 664.063,9.3819490224; 664.562,
            9.4189908336; 665.06,9.4189908336; 665.56,9.390180536; 666.06,
            9.41075932; 666.56,9.369601752; 667.06,9.41075932; 667.56,
            9.4436853744; 668.06,9.4354538608; 668.56,9.4272223472; 669.06,
            9.4189908336; 669.562,9.5054217264; 670.062,9.4272223472; 670.563,
            9.493074456; 671.059,9.4807271856; 671.563,9.451916888; 672.062,
            9.4354538608; 672.559,9.4272223472; 673.06,9.5218847536; 673.56,
            9.4601484016; 674.059,9.51365324; 674.56,9.5054217264; 675.06,
            9.493074456; 675.56,9.4807271856; 676.06,9.4601484016; 676.56,
            9.4436853744; 677.06,9.4766114288; 677.562,9.4766114288; 678.062,
            9.4436853744; 678.563,9.4807271856; 679.064,9.4272223472; 679.562,
            9.5218847536; 680.062,9.5095374832; 680.563,9.493074456; 681.063,
            9.5424635376; 681.559,9.5054217264; 682.062,9.5383477808; 682.561,
            9.4560326448; 683.063,9.41075932; 683.56,9.451916888; 684.063,
            9.3819490224; 684.564,9.4025278064; 685.062,9.4189908336; 685.564,
            9.451916888; 686.062,9.431338104; 686.56,9.4889586992; 687.063,
            9.575389592; 687.561,9.5712738352; 688.06,9.5218847536; 688.561,
            9.5795053488; 689.059,9.5630423216; 689.559,9.5630423216; 690.064,
            9.5630423216; 690.563,9.4889586992; 691.061,9.4642641584; 691.564,
            9.4272223472; 692.059,9.4272223472; 692.561,9.3942962928; 693.06,
            9.4148750768; 693.562,9.5013059696; 694.061,9.4601484016; 694.559,
            9.451916888; 695.06,9.4766114288; 695.56,9.3860647792; 696.062,
            9.4066435632; 696.561,9.3778332656; 697.061,9.3984120496; 697.561,
            9.4189908336; 698.061,9.41075932; 698.559,9.4601484016; 699.062,
            9.4601484016; 699.562,9.4189908336; 700.062,9.3819490224; 700.562,
            9.4025278064; 701.062,9.4066435632; 701.562,9.41075932; 702.062,
            9.4148750768; 702.56,9.4848429424; 703.062,9.4601484016; 703.563,
            9.472495672; 704.063,9.493074456; 704.563,9.554810808; 705.063,
            9.5054217264; 705.562,9.5260005104; 706.063,9.5095374832; 706.563,
            9.4807271856; 707.063,9.5177689968; 707.559,9.5424635376; 708.063,
            9.4766114288; 708.56,9.5260005104; 709.061,9.4642641584; 709.56,
            9.4436853744; 710.059,9.4766114288; 710.56,9.4683799152; 711.059,
            9.4807271856; 711.561,9.4766114288; 712.062,9.4642641584; 712.559,
            9.4807271856; 713.063,9.4601484016; 713.562,9.5054217264; 714.063,
            9.5260005104; 714.563,9.5013059696; 715.062,9.493074456; 715.563,
            9.4601484016; 716.062,9.4560326448; 716.562,9.5013059696; 717.063,
            9.5013059696; 717.559,9.5218847536; 718.063,9.4971902128; 718.562,
            9.51365324; 719.062,9.5589265648; 719.56,9.554810808; 720.06,
            9.5218847536; 720.562,9.5465792944; 721.064,9.4807271856; 721.563,
            9.4354538608; 722.063,9.451916888; 722.559,9.5424635376; 723.062,
            9.4807271856; 723.561,9.5218847536; 724.061,9.4807271856; 724.563,
            9.534232024; 725.062,9.5095374832; 725.562,9.5013059696; 726.061,
            9.4601484016; 726.562,9.5013059696; 727.063,9.4189908336; 727.56,
            9.4642641584; 728.061,9.4478011312; 728.56,9.4148750768; 729.063,
            9.451916888; 729.56,9.5054217264; 730.063,9.493074456; 730.562,
            9.5260005104; 731.063,9.575389592; 731.563,9.4971902128; 732.062,
            9.5054217264; 732.561,9.472495672; 733.062,9.4683799152; 733.562,
            9.4766114288; 734.062,9.4601484016; 734.564,9.472495672; 735.063,
            9.51365324; 735.56,9.5301162672; 736.062,9.4889586992; 736.56,
            9.4848429424; 737.063,9.4683799152; 737.56,9.451916888; 738.062,
            9.4766114288; 738.562,9.493074456; 739.062,9.4807271856; 739.561,
            9.4642641584; 740.062,9.5013059696; 740.562,9.5260005104; 741.062,
            9.5013059696; 741.563,9.4766114288; 742.063,9.472495672; 742.561,
            9.493074456; 743.063,9.5054217264; 743.562,9.5383477808; 744.062,
            9.5260005104; 744.56,9.5260005104; 745.061,9.4971902128; 745.563,
            9.4971902128; 746.061,9.5301162672; 746.562,9.5054217264; 747.061,
            9.4807271856; 747.56,9.493074456; 748.061,9.4766114288; 748.561,
            9.4848429424; 749.061,9.5465792944; 749.562,9.51365324; 750.061,
            9.5177689968; 750.56,9.5383477808; 751.062,9.5177689968; 751.559,
            9.493074456; 752.061,9.4642641584; 752.56,9.4642641584; 753.06,
            9.4560326448; 753.56,9.4436853744; 754.06,9.4436853744; 754.56,
            9.3572544816; 755.06,9.4148750768; 755.559,9.4971902128; 756.06,
            9.4889586992; 756.563,9.4807271856; 757.06,9.5054217264; 757.561,
            9.5177689968; 758.059,9.5177689968; 758.562,9.4848429424; 759.061,
            9.51365324; 759.563,9.5054217264; 760.063,9.5095374832; 760.563,
            9.5013059696; 761.062,9.51365324; 761.563,9.5795053488; 762.063,
            9.5177689968; 762.561,9.554810808; 763.06,9.5260005104; 763.563,
            9.5095374832; 764.063,9.4601484016; 764.562,9.4478011312; 765.063,
            9.3860647792; 765.56,9.3984120496; 766.063,9.349022968; 766.563,
            9.3654859952; 767.063,9.3737175088; 767.562,9.3984120496; 768.062,
            9.41075932; 768.562,9.4354538608; 769.063,9.431338104; 769.562,
            9.431338104; 770.062,9.493074456; 770.56,9.4642641584; 771.061,
            9.5177689968; 771.564,9.451916888; 772.063,9.4478011312; 772.563,
            9.431338104; 773.063,9.4601484016; 773.563,9.4436853744; 774.062,
            9.4436853744; 774.562,9.4231065904; 775.063,9.4436853744; 775.561,
            9.4272223472; 776.063,9.4354538608; 776.562,9.4395696176; 777.061,
            9.4066435632; 777.562,9.4272223472; 778.064,9.4231065904; 778.561,
            9.3654859952; 779.063,9.451916888; 779.567,9.3984120496; 780.063,
            9.4436853744; 780.562,9.4683799152; 781.063,9.5218847536; 781.562,
            9.6124314032; 782.062,9.6247786736; 782.564,9.5795053488; 783.063,
            9.5712738352; 783.563,9.5836211056; 784.065,9.5013059696; 784.563,
            9.5095374832; 785.063,9.5260005104; 785.562,9.5013059696; 786.063,
            9.472495672; 786.563,9.472495672; 787.062,9.4478011312; 787.563,
            9.4354538608; 788.062,9.4189908336; 788.561,9.4560326448; 789.06,
            9.4683799152; 789.56,9.4354538608; 790.062,9.4436853744; 790.561,
            9.4354538608; 791.06,9.4683799152; 791.56,9.4560326448; 792.059,
            9.4848429424; 792.56,9.4601484016; 793.059,9.4560326448; 793.562,
            9.4807271856; 794.061,9.51365324; 794.56,9.5260005104; 795.061,
            9.4601484016; 795.561,9.5013059696; 796.061,9.51365324; 796.56,
            9.4971902128; 797.062,9.5013059696; 797.561,9.5301162672; 798.061,
            9.451916888; 798.561,9.4971902128; 799.062,9.4807271856; 799.56,
            9.4807271856; 800.061,9.4848429424; 800.561,9.4395696176; 801.061,
            9.4189908336; 801.561,9.4231065904; 802.062,9.4683799152; 802.56,
            9.5095374832; 803.059,9.5013059696; 803.56,9.51365324; 804.061,
            9.4848429424; 804.561,9.4889586992; 805.061,9.5054217264; 805.561,
            9.4848429424; 806.061,9.4848429424; 806.561,9.4478011312; 807.061,
            9.4766114288; 807.561,9.4683799152; 808.06,9.472495672; 808.562,
            9.4766114288; 809.062,9.4683799152; 809.561,9.4436853744; 810.061,
            9.4642641584; 810.562,9.4642641584; 811.06,9.4189908336; 811.56,
            9.3819490224; 812.063,9.4066435632; 812.561,9.3860647792; 813.061,
            9.41075932; 813.562,9.3449072112; 814.062,9.431338104; 814.56,
            9.4395696176; 815.06,9.4272223472; 815.56,9.4560326448; 816.062,
            9.4766114288; 816.563,9.472495672; 817.06,9.5054217264; 817.56,
            9.5260005104; 818.06,9.4683799152; 818.56,9.5424635376; 819.061,
            9.5465792944; 819.56,9.5424635376; 820.06,9.472495672; 820.561,
            9.4848429424; 821.061,9.4971902128; 821.56,9.4971902128; 822.061,
            9.4601484016; 822.561,9.5013059696; 823.061,9.451916888; 823.56,
            9.5013059696; 824.061,9.4971902128; 824.56,9.493074456; 825.059,
            9.4889586992; 825.56,9.4066435632; 826.06,9.4601484016; 826.56,
            9.431338104; 827.061,9.493074456; 827.561,9.4889586992; 828.06,
            9.451916888; 828.561,9.4395696176; 829.06,9.4272223472; 829.562,
            9.4478011312; 830.061,9.472495672; 830.561,9.4642641584; 831.06,
            9.472495672; 831.56,9.4354538608; 832.061,9.4272223472; 832.56,
            9.4395696176; 833.063,9.4560326448; 833.56,9.4560326448; 834.061,
            9.4807271856; 834.561,9.4478011312; 835.063,9.4560326448; 835.56,
            9.4395696176; 836.061,9.4601484016; 836.561,9.4560326448; 837.06,
            9.451916888; 837.563,9.4560326448; 838.062,9.472495672; 838.561,
            9.3942962928; 839.062,9.4148750768; 839.561,9.3572544816; 840.063,
            9.369601752; 840.559,9.3778332656; 841.061,9.369601752; 841.562,
            9.349022968; 842.064,9.3860647792; 842.561,9.4231065904; 843.061,
            9.3737175088; 843.564,9.4436853744; 844.063,9.4066435632; 844.563,
            9.4272223472; 845.062,9.3860647792; 845.56,9.4560326448; 846.064,
            9.472495672; 846.562,9.472495672; 847.064,9.4560326448; 847.56,
            9.431338104; 848.064,9.451916888; 848.563,9.4189908336; 849.063,
            9.4807271856; 849.563,9.4642641584; 850.06,9.4560326448; 850.562,
            9.4766114288; 851.062,9.4478011312; 851.563,9.3984120496; 852.063,
            9.3819490224; 852.561,9.3942962928; 853.061,9.4231065904; 853.564,
            9.3984120496; 854.064,9.4478011312; 854.562,9.4354538608; 855.062,
            9.472495672; 855.564,9.4436853744; 856.061,9.4189908336; 856.563,
            9.4807271856; 857.063,9.4395696176; 857.564,9.4848429424; 858.064,
            9.4354538608; 858.561,9.4889586992; 859.063,9.4272223472; 859.562,
            9.4560326448; 860.063,9.4189908336; 860.563,9.4231065904; 861.06,
            9.3778332656; 861.562,9.4231065904; 862.065,9.4601484016; 862.564,
            9.4478011312; 863.061,9.4889586992; 863.563,9.4395696176; 864.063,
            9.431338104; 864.561,9.4354538608; 865.062,9.4148750768; 865.564,
            9.4354538608; 866.063,9.4025278064; 866.561,9.3984120496; 867.062,
            9.41075932; 867.563,9.3942962928; 868.062,9.4272223472; 868.562,
            9.4436853744; 869.063,9.4766114288; 869.562,9.4478011312; 870.063,
            9.4889586992; 870.56,9.5095374832; 871.064,9.5301162672; 871.564,
            9.4395696176; 872.062,9.4272223472; 872.562,9.41075932; 873.063,
            9.390180536; 873.562,9.4354538608; 874.062,9.4683799152; 874.56,
            9.4601484016; 875.064,9.4642641584; 875.562,9.51365324; 876.064,
            9.4807271856; 876.563,9.4971902128; 877.063,9.5465792944; 877.562,
            9.5013059696; 878.063,9.4971902128; 878.564,9.5836211056; 879.062,
            9.5095374832; 879.563,9.554810808; 880.063,9.4889586992; 880.564,
            9.5424635376; 881.061,9.5630423216; 881.563,9.5095374832; 882.063,
            9.5424635376; 882.564,9.5589265648; 883.063,9.5795053488; 883.562,
            9.575389592; 884.065,9.5260005104; 884.563,9.5301162672; 885.063,
            9.5383477808; 885.564,9.5506950512; 886.064,9.5671580784; 886.562,
            9.595968376; 887.063,9.6247786736; 887.564,9.5877368624; 888.062,
            9.5424635376; 888.563,9.5465792944; 889.063,9.5424635376; 889.564,
            9.5465792944; 890.063,9.5383477808; 890.562,9.51365324; 891.062,
            9.5424635376; 891.563,9.5671580784; 892.063,9.5795053488; 892.564,
            9.595968376; 893.063,9.5424635376; 893.564,9.5712738352; 894.063,
            9.5671580784; 894.563,9.6000841328; 895.062,9.5671580784; 895.565,
            9.5465792944; 896.062,9.5260005104; 896.563,9.5301162672; 897.063,
            9.5630423216; 897.565,9.5424635376; 898.062,9.5177689968; 898.563,
            9.5260005104; 899.064,9.4971902128; 899.563,9.4848429424; 900.063,
            9.5095374832; 900.563,9.4971902128; 901.063,9.51365324; 901.564,
            9.5260005104; 902.065,9.5424635376; 902.562,9.5383477808; 903.063,
            9.4272223472; 903.564,9.4436853744; 904.063,9.5260005104; 904.563,
            9.4601484016; 905.063,9.431338104; 905.562,9.4971902128; 906.063,
            9.451916888; 906.562,9.4971902128; 907.062,9.5260005104; 907.564,
            9.4889586992; 908.064,9.5301162672; 908.564,9.4971902128; 909.062,
            9.51365324; 909.563,9.5177689968; 910.062,9.51365324; 910.56,
            9.4971902128; 911.063,9.554810808; 911.563,9.5465792944; 912.064,
            9.534232024; 912.562,9.5095374832; 913.063,9.534232024; 913.563,
            9.5671580784; 914.063,9.5506950512; 914.564,9.5424635376; 915.064,
            9.5218847536; 915.563,9.5506950512; 916.063,9.6083156464; 916.564,
            9.554810808; 917.063,9.5918526192; 917.565,9.5795053488; 918.063,
            9.5465792944; 918.564,9.534232024; 919.065,9.493074456; 919.564,
            9.5383477808; 920.065,9.5506950512; 920.562,9.5918526192; 921.063,
            9.5177689968; 921.565,9.5712738352; 922.063,9.6041998896; 922.564,
            9.5836211056; 923.065,9.5795053488; 923.562,9.575389592; 924.062,
            9.5506950512; 924.564,9.5918526192; 925.061,9.6124314032; 925.562,
            9.6083156464; 926.062,9.6330101872; 926.559,9.6535889712; 927.063,
            9.6741677552; 927.565,9.6453574576; 928.063,9.61654716; 928.563,
            9.61654716; 929.064,9.6124314032; 929.563,9.6083156464; 930.064,
            9.7070938096; 930.564,9.678283512; 931.064,9.6247786736; 931.563,
            9.5795053488; 932.064,9.5424635376; 932.563,9.5877368624; 933.064,
            9.6000841328; 933.564,9.595968376; 934.062,9.6124314032; 934.563,
            9.6124314032; 935.063,9.6494732144; 935.562,9.6000841328; 936.063,
            9.5506950512; 936.56,9.5506950512; 937.06,9.554810808; 937.563,
            9.5383477808; 938.063,9.5712738352; 938.563,9.5589265648; 939.065,
            9.61654716; 939.565,9.5589265648; 940.064,9.5301162672; 940.563,
            9.554810808; 941.065,9.5589265648; 941.562,9.5795053488; 942.065,
            9.5465792944; 942.562,9.5918526192; 943.063,9.6041998896; 943.563,
            9.5506950512; 944.063,9.595968376; 944.565,9.5465792944; 945.063,
            9.5630423216; 945.563,9.5301162672; 946.064,9.534232024; 946.563,
            9.5301162672; 947.062,9.575389592; 947.565,9.5630423216; 948.063,
            9.5630423216; 948.564,9.5712738352; 949.065,9.5589265648; 949.564,
            9.5671580784; 950.06,9.5465792944; 950.564,9.5589265648; 951.065,
            9.5918526192; 951.56,9.5630423216; 952.06,9.6124314032; 952.563,
            9.575389592; 953.062,9.5712738352; 953.563,9.5877368624; 954.064,
            9.5301162672; 954.563,9.4683799152; 955.062,9.5095374832; 955.563,
            9.4272223472; 956.063,9.51365324; 956.561,9.5383477808; 957.063,
            9.493074456; 957.563,9.534232024; 958.062,9.5630423216; 958.564,
            9.5671580784; 959.064,9.595968376; 959.563,9.5836211056; 960.063,
            9.6412417008; 960.562,9.5424635376; 961.062,9.6041998896; 961.563,
            9.5877368624; 962.061,9.595968376; 962.561,9.6000841328; 963.064,
            9.6041998896; 963.562,9.6206629168; 964.062,9.5877368624; 964.564,
            9.637125944; 965.063,9.575389592; 965.561,9.4642641584; 966.064,
            9.493074456; 966.562,9.5177689968; 967.063,9.554810808; 967.565,
            9.6947465392; 968.062,9.7441356208; 968.563,9.7359041072; 969.061,
            9.7112095664; 969.563,9.7359041072; 970.063,9.7070938096; 970.564,
            9.698862296; 971.064,9.6494732144; 971.563,9.7153253232; 972.063,
            9.7317883504; 972.563,9.7070938096; 973.061,9.7070938096; 973.563,
            9.6412417008; 974.063,9.5465792944; 974.564,9.6124314032; 975.063,
            9.6535889712; 975.563,9.6412417008; 976.063,9.6535889712; 976.562,
            9.657704728; 977.064,9.5506950512; 977.563,9.595968376; 978.064,
            9.6247786736; 978.563,9.595968376; 979.065,9.5630423216; 979.563,
            9.5671580784; 980.064,9.6041998896; 980.564,9.6000841328; 981.061,
            9.5506950512; 981.563,9.5013059696; 982.063,9.5506950512; 982.563,
            9.575389592; 983.063,9.4848429424; 983.564,9.5301162672; 984.064,
            9.5712738352; 984.564,9.5506950512; 985.065,9.5712738352; 985.562,
            9.554810808; 986.063,9.6041998896; 986.565,9.5589265648; 987.064,
            9.5506950512; 987.563,9.6247786736; 988.062,9.5877368624; 988.564,
            9.6412417008; 989.064,9.5877368624; 989.564,9.5506950512; 990.064,
            9.5260005104; 990.563,9.6247786736; 991.064,9.5260005104; 991.56,
            9.6000841328; 992.063,9.6288944304; 992.563,9.6247786736; 993.064,
            9.5465792944; 993.563,9.5836211056; 994.062,9.5506950512; 994.564,
            9.6000841328; 995.063,9.5424635376; 995.563,9.5589265648; 996.062,
            9.5712738352; 996.563,9.6247786736; 997.064,9.5301162672; 997.564,
            9.575389592; 998.063,9.6330101872; 998.563,9.6247786736; 999.062,
            9.6659362416; 999.564,9.6494732144; 1000.065,9.6494732144; 1000.564,
            9.6535889712; 1001.063,9.6330101872; 1001.565,9.657704728; 1002.064,
            9.5836211056; 1002.565,9.6247786736; 1003.062,9.6823992688;
            1003.564,9.6823992688; 1004.063,9.7317883504; 1004.564,9.6247786736;
            1005.063,9.657704728; 1005.564,9.7029780528; 1006.062,9.6000841328;
            1006.564,9.6124314032; 1007.063,9.6124314032; 1007.562,9.575389592;
            1008.061,9.5836211056; 1008.565,9.61654716; 1009.063,9.5795053488;
            1009.564,9.6453574576; 1010.063,9.5260005104; 1010.563,9.595968376;
            1011.063,9.5877368624; 1011.562,9.5630423216; 1012.063,9.5589265648;
            1012.564,9.6083156464; 1013.062,9.6124314032; 1013.562,9.6700519984;
            1014.063,9.6741677552; 1014.564,9.5630423216; 1015.063,9.6083156464;
            1015.563,9.6535889712; 1016.064,9.6330101872; 1016.563,9.637125944;
            1017.063,9.6494732144; 1017.562,9.6206629168; 1018.06,9.6288944304;
            1018.563,9.575389592; 1019.063,9.61654716; 1019.563,9.575389592;
            1020.064,9.6000841328; 1020.564,9.595968376; 1021.063,9.61654716;
            1021.563,9.6206629168; 1022.062,9.575389592; 1022.562,9.5424635376;
            1023.06,9.5383477808; 1023.564,9.5671580784; 1024.065,9.595968376;
            1024.563,9.6700519984; 1025.064,9.698862296; 1025.563,9.6823992688;
            1026.064,9.6659362416; 1026.565,9.6741677552; 1027.063,9.6124314032;
            1027.565,9.6247786736; 1028.06,9.6000841328; 1028.564,9.5836211056;
            1029.062,9.6288944304; 1029.564,9.657704728; 1030.064,9.5877368624;
            1030.564,9.6206629168; 1031.064,9.595968376; 1031.564,9.554810808;
            1032.063,9.6041998896; 1032.564,9.5795053488; 1033.06,9.6453574576;
            1033.563,9.6288944304; 1034.063,9.6453574576; 1034.564,9.6412417008;
            1035.064,9.6618204848; 1035.562,9.6206629168; 1036.064,9.6700519984;
            1036.564,9.6865150256; 1037.062,9.71944108; 1037.564,9.6494732144;
            1038.062,9.6906307824; 1038.563,9.6618204848; 1039.063,9.657704728;
            1039.563,9.6453574576; 1040.063,9.637125944; 1040.564,9.5671580784;
            1041.066,9.5836211056; 1041.562,9.5465792944; 1042.063,9.5054217264;
            1042.562,9.6041998896; 1043.064,9.5301162672; 1043.563,9.6288944304;
            1044.063,9.5671580784; 1044.561,9.6041998896; 1045.063,9.5877368624;
            1045.563,9.6494732144; 1046.064,9.5918526192; 1046.562,9.61654716;
            1047.063,9.6124314032; 1047.563,9.5671580784; 1048.062,9.6083156464;
            1048.562,9.6124314032; 1049.064,9.6247786736; 1049.563,9.5795053488;
            1050.062,9.575389592; 1050.563,9.575389592; 1051.063,9.5506950512;
            1051.564,9.6000841328; 1052.063,9.5630423216; 1052.563,9.575389592;
            1053.062,9.5877368624; 1053.563,9.5836211056; 1054.061,9.6206629168;
            1054.563,9.5877368624; 1055.064,9.6288944304; 1055.564,9.637125944;
            1056.064,9.6494732144; 1056.564,9.61654716; 1057.063,9.6659362416;
            1057.565,9.637125944; 1058.063,9.6535889712; 1058.565,9.6906307824;
            1059.064,9.6741677552; 1059.565,9.6659362416; 1060.062,9.6823992688;
            1060.563,9.7070938096; 1061.064,9.6823992688; 1061.563,9.678283512;
            1062.063,9.71944108; 1062.563,9.698862296; 1063.065,9.6741677552;
            1063.562,9.7359041072; 1064.063,9.678283512; 1064.564,9.6618204848;
            1065.063,9.6453574576; 1065.564,9.6330101872; 1066.064,9.6453574576;
            1066.565,9.6041998896; 1067.064,9.6206629168; 1067.565,9.61654716;
            1068.064,9.637125944; 1068.564,9.6494732144; 1069.064,9.6412417008;
            1069.564,9.6659362416; 1070.064,9.7276725936; 1070.564,9.6906307824;
            1071.064,9.7029780528; 1071.562,9.6412417008; 1072.063,9.6865150256;
            1072.565,9.6947465392; 1073.064,9.7317883504; 1073.564,9.6823992688;
            1074.063,9.7112095664; 1074.564,9.678283512; 1075.062,9.698862296;
            1075.562,9.7070938096; 1076.063,9.7482513776; 1076.562,9.7235568368;
            1077.064,9.7564828912; 1077.562,9.7647144048; 1078.063,9.7976404592;
            1078.562,9.781177432; 1079.064,9.7852931888; 1079.564,9.7935247024;
            1080.064,9.7770616752; 1080.562,9.7482513776; 1081.064,9.7317883504;
            1081.56,9.7647144048; 1082.064,9.7276725936; 1082.565,9.7153253232;
            1083.064,9.678283512; 1083.563,9.6412417008; 1084.064,9.6288944304;
            1084.562,9.6412417008; 1085.064,9.678283512; 1085.564,9.6659362416;
            1086.064,9.6535889712; 1086.564,9.6453574576; 1087.062,9.6494732144;
            1087.563,9.6247786736; 1088.062,9.6330101872; 1088.563,9.6494732144;
            1089.064,9.6947465392; 1089.562,9.7029780528; 1090.063,9.7235568368;
            1090.564,9.7112095664; 1091.065,9.698862296; 1091.561,9.6947465392;
            1092.063,9.6823992688; 1092.563,9.740019864; 1093.064,9.7112095664;
            1093.564,9.7317883504; 1094.064,9.7647144048; 1094.563,9.7688301616;
            1095.063,9.6947465392; 1095.563,9.6412417008; 1096.065,9.6618204848;
            1096.564,9.595968376; 1097.063,9.5795053488; 1097.564,9.6206629168;
            1098.062,9.6206629168; 1098.563,9.657704728; 1099.063,9.595968376;
            1099.563,9.6412417008; 1100.064,9.698862296; 1100.563,9.6947465392;
            1101.064,9.7317883504; 1101.564,9.7276725936; 1102.063,9.7029780528;
            1102.563,9.6700519984; 1103.063,9.678283512; 1103.565,9.6823992688;
            1104.064,9.6947465392; 1104.564,9.7482513776; 1105.065,9.7359041072;
            1105.562,9.7112095664; 1106.064,9.7317883504; 1106.563,9.740019864;
            1107.063,9.7729459184; 1107.561,9.7564828912; 1108.062,9.7070938096;
            1108.563,9.6618204848; 1109.061,9.7276725936; 1109.563,9.678283512;
            1110.063,9.698862296; 1110.562,9.71944108; 1111.061,9.6947465392;
            1111.56,9.7482513776; 1112.059,9.7112095664; 1112.561,9.7770616752;
            1113.06,9.7029780528; 1113.561,9.7441356208; 1114.062,9.6823992688;
            1114.56,9.7112095664; 1115.061,9.7070938096; 1115.561,9.740019864;
            1116.061,9.7070938096; 1116.562,9.7070938096; 1117.061,9.7441356208;
            1117.563,9.7359041072; 1118.063,9.6823992688; 1118.563,9.698862296;
            1119.064,9.6659362416; 1119.563,9.6618204848; 1120.063,9.637125944;
            1120.563,9.61654716; 1121.063,9.6206629168; 1121.563,9.5836211056;
            1122.063,9.61654716; 1122.565,9.6000841328; 1123.064,9.6535889712;
            1123.56,9.6494732144; 1124.063,9.6330101872; 1124.564,9.5877368624;
            1125.064,9.6083156464; 1125.564,9.6412417008; 1126.063,9.6618204848;
            1126.563,9.637125944; 1127.064,9.657704728; 1127.564,9.657704728;
            1128.064,9.6659362416; 1128.564,9.6288944304; 1129.063,9.61654716;
            1129.565,9.6206629168; 1130.064,9.6453574576; 1130.564,9.595968376;
            1131.064,9.595968376; 1131.565,9.6412417008; 1132.064,9.6000841328;
            1132.564,9.575389592; 1133.065,9.6083156464; 1133.562,9.637125944;
            1134.064,9.6906307824; 1134.563,9.7070938096; 1135.065,9.7112095664;
            1135.564,9.7070938096; 1136.064,9.7235568368; 1136.563,9.7070938096;
            1137.065,9.7153253232; 1137.565,9.698862296; 1138.064,9.6247786736;
            1138.562,9.6206629168; 1139.061,9.6041998896; 1139.564,9.6124314032;
            1140.063,9.61654716; 1140.564,9.657704728; 1141.064,9.6741677552;
            1141.564,9.6659362416; 1142.065,9.6865150256; 1142.563,9.637125944;
            1143.064,9.6823992688; 1143.564,9.6659362416; 1144.064,9.637125944;
            1144.563,9.6659362416; 1145.064,9.6535889712; 1145.563,9.657704728;
            1146.063,9.6741677552; 1146.565,9.6659362416; 1147.063,9.6535889712;
            1147.564,9.6741677552; 1148.063,9.6659362416; 1148.563,9.7029780528;
            1149.062,9.6700519984; 1149.563,9.7153253232; 1150.064,9.7153253232;
            1150.564,9.6823992688; 1151.063,9.6659362416; 1151.564,9.6700519984;
            1152.062,9.6618204848; 1152.565,9.6947465392; 1153.063,9.6865150256;
            1153.563,9.71944108; 1154.063,9.7112095664; 1154.564,9.678283512;
            1155.065,9.6906307824; 1155.564,9.6906307824; 1156.062,9.7276725936;
            1156.564,9.7112095664; 1157.065,9.7029780528; 1157.563,9.6741677552;
            1158.063,9.7029780528; 1158.563,9.7070938096; 1159.063,9.7523671344;
            1159.564,9.6906307824; 1160.063,9.6700519984; 1160.564,9.698862296;
            1161.065,9.7112095664; 1161.564,9.6865150256; 1162.062,9.6823992688;
            1162.564,9.7153253232; 1163.063,9.7317883504; 1163.563,9.678283512;
            1164.063,9.6906307824; 1164.564,9.657704728; 1165.063,9.6330101872;
            1165.562,9.6412417008; 1166.064,9.6247786736; 1166.56,9.657704728;
            1167.064,9.6535889712; 1167.56,9.7441356208; 1168.064,9.781177432;
            1168.563,9.7647144048; 1169.065,9.7564828912; 1169.563,9.7729459184;
            1170.062,9.7359041072; 1170.563,9.760598648; 1171.063,9.7523671344;
            1171.563,9.7235568368; 1172.062,9.6947465392; 1172.563,9.7276725936;
            1173.064,9.7235568368; 1173.564,9.6947465392; 1174.061,9.6659362416;
            1174.564,9.6865150256; 1175.065,9.6865150256; 1175.563,9.6906307824;
            1176.065,9.7688301616; 1176.564,9.7112095664; 1177.064,9.7770616752;
            1177.563,9.7482513776; 1178.063,9.7359041072; 1178.562,9.7523671344;
            1179.064,9.7523671344; 1179.563,9.7564828912; 1180.063,9.7729459184;
            1180.564,9.7276725936; 1181.065,9.698862296; 1181.563,9.6412417008;
            1182.064,9.657704728; 1182.563,9.698862296; 1183.064,9.7112095664;
            1183.563,9.678283512; 1184.06,9.6865150256; 1184.562,9.6700519984;
            1185.063,9.698862296; 1185.561,9.71944108; 1186.062,9.7112095664;
            1186.561,9.6865150256; 1187.064,9.6741677552; 1187.563,9.7688301616;
            1188.063,9.7317883504; 1188.563,9.760598648; 1189.064,9.7976404592;
            1189.563,9.781177432; 1190.064,9.7770616752; 1190.564,9.7688301616;
            1191.063,9.8141034864; 1191.563,9.7359041072; 1192.064,9.8099877296;
            1192.563,9.7729459184; 1193.065,9.8099877296; 1193.564,9.7976404592;
            1194.063,9.8058719728; 1194.564,9.7482513776; 1195.063,9.71944108;
            1195.562,9.698862296; 1196.064,9.7359041072; 1196.564,9.7317883504;
            1197.063,9.71944108; 1197.564,9.6865150256; 1198.064,9.7235568368;
            1198.563,9.657704728; 1199.065,9.6206629168; 1199.563,9.6618204848;
            1200.064,9.61654716; 1200.562,9.6412417008; 1201.064,9.6041998896;
            1201.564,9.6083156464; 1202.063,9.595968376; 1202.562,9.6000841328;
            1203.063,9.5836211056; 1203.563,9.595968376; 1204.062,9.6041998896;
            1204.565,9.6330101872; 1205.064,9.6947465392; 1205.564,9.6823992688;
            1206.063,9.7153253232; 1206.563,9.7153253232; 1207.063,9.6906307824;
            1207.563,9.6906307824; 1208.064,9.7276725936; 1208.563,9.71944108;
            1209.061,9.6823992688; 1209.564,9.6741677552; 1210.062,9.698862296;
            1210.56,9.6823992688; 1211.062,9.6700519984; 1211.562,9.6947465392;
            1212.062,9.6247786736; 1212.564,9.6330101872; 1213.062,9.6412417008;
            1213.564,9.637125944; 1214.064,9.6453574576; 1214.56,9.6700519984;
            1215.064,9.698862296; 1215.562,9.678283512; 1216.061,9.6741677552;
            1216.564,9.7276725936; 1217.065,9.6494732144; 1217.564,9.7112095664;
            1218.063,9.6618204848; 1218.564,9.698862296; 1219.063,9.7029780528;
            1219.563,9.7359041072; 1220.063,9.760598648; 1220.564,9.7729459184;
            1221.063,9.7235568368; 1221.562,9.781177432; 1222.063,9.7235568368;
            1222.562,9.7894089456; 1223.065,9.8058719728; 1223.562,9.7153253232;
            1224.064,9.6700519984; 1224.564,9.6659362416; 1225.064,9.6741677552;
            1225.564,9.6618204848; 1226.064,9.6865150256; 1226.562,9.6906307824;
            1227.062,9.6659362416; 1227.564,9.6535889712; 1228.063,9.7112095664;
            1228.561,9.6906307824; 1229.064,9.7153253232; 1229.565,9.7153253232;
            1230.064,9.7153253232; 1230.564,9.7112095664; 1231.064,9.7647144048;
            1231.564,9.71944108; 1232.063,9.781177432; 1232.564,9.7482513776;
            1233.064,9.7564828912; 1233.562,9.6865150256; 1234.062,9.6741677552;
            1234.566,9.6659362416; 1235.065,9.6535889712; 1235.564,9.6288944304;
            1236.065,9.575389592; 1236.563,9.6659362416; 1237.064,9.6618204848;
            1237.564,9.6865150256; 1238.063,9.7482513776; 1238.563,9.760598648;
            1239.064,9.7976404592; 1239.562,9.7770616752; 1240.064,9.7647144048;
            1240.564,9.7359041072; 1241.064,9.7770616752; 1241.564,9.7482513776;
            1242.063,9.7276725936; 1242.561,9.7070938096; 1243.063,9.740019864;
            1243.564,9.7029780528; 1244.063,9.71944108; 1244.565,9.7482513776;
            1245.064,9.7935247024; 1245.563,9.801756216; 1246.064,9.8387980272;
            1246.563,9.801756216; 1247.062,9.8346822704; 1247.564,9.7688301616;
            1248.065,9.7523671344; 1248.56,9.8141034864; 1249.065,9.7523671344;
            1249.563,9.7564828912; 1250.065,9.698862296; 1250.565,9.781177432;
            1251.062,9.7317883504; 1251.564,9.7647144048; 1252.065,9.7276725936;
            1252.562,9.7317883504; 1253.064,9.7029780528; 1253.563,9.7153253232;
            1254.064,9.6618204848; 1254.563,9.6947465392; 1255.065,9.740019864;
            1255.564,9.760598648; 1256.064,9.6906307824; 1256.563,9.7359041072;
            1257.063,9.7359041072; 1257.564,9.7112095664; 1258.064,9.7153253232;
            1258.562,9.7482513776; 1259.062,9.7153253232; 1259.566,9.7153253232;
            1260.064,9.7029780528; 1260.562,9.6659362416; 1261.063,9.6865150256;
            1261.564,9.6124314032; 1262.063,9.6453574576; 1262.563,9.6288944304;
            1263.063,9.61654716; 1263.562,9.6288944304; 1264.059,9.678283512;
            1264.561,9.6906307824; 1265.064,9.6906307824; 1265.564,9.6700519984;
            1266.063,9.7235568368; 1266.564,9.6412417008; 1267.063,9.657704728;
            1267.564,9.6700519984; 1268.063,9.7112095664; 1268.561,9.7317883504;
            1269.063,9.7153253232; 1269.564,9.760598648; 1270.065,9.6823992688;
            1270.563,9.7523671344; 1271.064,9.7359041072; 1271.563,9.760598648;
            1272.063,9.8058719728; 1272.563,9.7770616752; 1273.064,9.7482513776;
            1273.561,9.7894089456; 1274.063,9.7852931888; 1274.562,9.740019864;
            1275.063,9.7647144048; 1275.56,9.7359041072; 1276.064,9.781177432;
            1276.563,9.7482513776; 1277.063,9.7029780528; 1277.564,9.6906307824;
            1278.064,9.6906307824; 1278.561,9.6865150256; 1279.063,9.6906307824;
            1279.564,9.6947465392; 1280.063,9.6947465392; 1280.565,9.7112095664;
            1281.064,9.7359041072; 1281.563,9.7317883504; 1282.063,9.71944108;
            1282.562,9.6823992688; 1283.061,9.7070938096; 1283.561,9.7112095664;
            1284.064,9.7441356208; 1284.562,9.7235568368; 1285.064,9.7317883504;
            1285.563,9.71944108; 1286.065,9.7441356208; 1286.564,9.7276725936;
            1287.064,9.7647144048; 1287.564,9.6700519984; 1288.063,9.7482513776;
            1288.561,9.7647144048; 1289.063,9.6700519984; 1289.564,9.7359041072;
            1290.064,9.7070938096; 1290.563,9.7317883504; 1291.064,9.7523671344;
            1291.565,9.7359041072; 1292.064,9.6906307824; 1292.564,9.6906307824;
            1293.064,9.7359041072; 1293.562,9.7070938096; 1294.061,9.7441356208;
            1294.562,9.7852931888; 1295.065,9.781177432; 1295.563,9.7647144048;
            1296.061,9.7112095664; 1296.564,9.6823992688; 1297.064,9.7441356208;
            1297.563,9.7276725936; 1298.064,9.7564828912; 1298.565,9.7441356208;
            1299.064,9.7688301616; 1299.565,9.7112095664; 1300.061,9.740019864;
            1300.564,9.6659362416; 1301.064,9.6494732144; 1301.563,9.6453574576;
            1302.064,9.6124314032; 1302.564,9.6000841328; 1303.063,9.657704728;
            1303.564,9.678283512; 1304.064,9.7153253232; 1304.564,9.698862296;
            1305.063,9.7317883504; 1305.564,9.7153253232; 1306.065,9.698862296;
            1306.564,9.7153253232; 1307.064,9.7441356208; 1307.563,9.7523671344;
            1308.063,9.7688301616; 1308.563,9.7276725936; 1309.065,9.740019864;
            1309.563,9.6865150256; 1310.065,9.6823992688; 1310.563,9.7235568368;
            1311.066,9.6453574576; 1311.564,9.7029780528; 1312.065,9.71944108;
            1312.562,9.7235568368; 1313.064,9.7729459184; 1313.56,9.760598648;
            1314.065,9.7523671344; 1314.565,9.7070938096; 1315.063,9.6947465392;
            1315.564,9.6247786736; 1316.062,9.6535889712; 1316.564,9.698862296;
            1317.061,9.71944108; 1317.563,9.7317883504; 1318.064,9.6947465392;
            1318.563,9.7235568368; 1319.063,9.7688301616; 1319.563,9.7688301616;
            1320.063,9.7482513776; 1320.562,9.7482513776; 1321.064,9.7276725936;
            1321.565,9.7153253232; 1322.063,9.760598648; 1322.561,9.740019864;
            1323.063,9.7359041072; 1323.563,9.7564828912; 1324.064,9.6906307824;
            1324.561,9.657704728; 1325.063,9.5877368624; 1325.565,9.6453574576;
            1326.062,9.7070938096; 1326.564,9.6906307824; 1327.07,9.7112095664;
            1327.564,9.7276725936; 1328.064,9.7441356208; 1328.564,9.740019864;
            1329.062,9.7729459184; 1329.565,9.7564828912; 1330.063,9.8141034864;
            1330.563,9.781177432; 1331.063,9.7976404592; 1331.566,9.7770616752;
            1332.063,9.760598648; 1332.561,9.781177432; 1333.062,9.8264507568;
            1333.563,9.8346822704; 1334.064,9.8141034864; 1334.564,9.7688301616;
            1335.063,9.7852931888; 1335.564,9.7852931888; 1336.063,9.7935247024;
            1336.564,9.8141034864; 1337.063,9.7976404592; 1337.564,9.8305665136;
            1338.064,9.801756216; 1338.564,9.7770616752; 1339.063,9.7276725936;
            1339.563,9.6906307824; 1340.064,9.7235568368; 1340.563,9.6947465392;
            1341.064,9.7235568368; 1341.563,9.7112095664; 1342.064,9.7153253232;
            1342.562,9.6906307824; 1343.064,9.7523671344; 1343.563,9.7852931888;
            1344.064,9.801756216; 1344.563,9.7564828912; 1345.064,9.8305665136;
            1345.564,9.760598648; 1346.063,9.8182192432; 1346.564,9.8099877296;
            1347.062,9.7935247024; 1347.565,9.7235568368; 1348.064,9.7482513776;
            1348.564,9.7852931888; 1349.061,9.7935247024; 1349.566,9.7770616752;
            1350.064,9.7647144048; 1350.566,9.760598648; 1351.064,9.7647144048;
            1351.563,9.7482513776; 1352.064,9.6906307824; 1352.564,9.698862296;
            1353.064,9.6659362416; 1353.565,9.6494732144; 1354.062,9.657704728;
            1354.564,9.6947465392; 1355.064,9.698862296; 1355.564,9.6700519984;
            1356.064,9.6947465392; 1356.564,9.698862296; 1357.064,9.6700519984;
            1357.564,9.7070938096; 1358.064,9.740019864; 1358.565,9.6865150256;
            1359.065,9.7359041072; 1359.565,9.7564828912; 1360.065,9.7523671344;
            1360.565,9.7235568368; 1361.064,9.7770616752; 1361.564,9.7482513776;
            1362.063,9.71944108; 1362.564,9.678283512; 1363.065,9.698862296;
            1363.561,9.7029780528; 1364.064,9.6947465392; 1364.563,9.6947465392;
            1365.063,9.7276725936; 1365.564,9.6947465392; 1366.065,9.6947465392;
            1366.564,9.71944108; 1367.064,9.7482513776; 1367.563,9.6865150256;
            1368.065,9.7276725936; 1368.562,9.6494732144; 1369.065,9.6453574576;
            1369.565,9.678283512; 1370.064,9.6823992688; 1370.564,9.7112095664;
            1371.064,9.7317883504; 1371.564,9.698862296; 1372.063,9.6947465392;
            1372.563,9.7029780528; 1373.064,9.7317883504; 1373.564,9.7564828912;
            1374.064,9.740019864; 1374.564,9.7852931888; 1375.065,9.7317883504;
            1375.564,9.7523671344; 1376.063,9.6906307824; 1376.565,9.5712738352;
            1377.064,8.9292157744; 1377.564,7.9661286832; 1378.064,7.0606621872;
            1378.564,6.3280574768; 1379.064,5.6366103344; 1379.564,5.109793464;
            1380.065,4.677639; 1380.565,4.2166742384; 1381.064,3.9738445872;
            1381.564,3.6322367728; 1382.065,3.4141016624; 1382.561,3.2453556336;
            1383.064,3.072493848; 1383.563,2.9654841712; 1384.063,2.804969656;
            1384.565,2.7103072496; 1385.065,2.6732654384; 1385.564,2.5662557616;
            1386.064,2.5004036528; 1386.565,2.4921721392; 1387.064,2.4098570032;
            1387.564,2.331657624; 1388.064,2.2822685424; 1388.564,2.2328794608;
            1389.063,2.249342488; 1389.564,2.1999534064; 1390.066,2.1546800816;
            1390.564,2.1793746224; 1391.065,2.146448568; 1391.564,2.1711431088;
            1392.064,2.146448568; 1392.563,2.1587958384; 1393.063,2.2040691632;
            1393.564,2.1999534064; 1394.064,2.2205321904; 1394.565,2.228763704;
            1395.063,2.2452267312; 1395.564,2.2987315696; 1396.065,2.2987315696;
            1396.565,2.269921272; 1397.063,2.3193103536; 1397.563,2.352236408;
            1398.063,2.4016254896; 1398.564,2.4468988144; 1399.063,2.4180885168;
            1399.567,2.4839406256; 1400.063,2.496287896; 1400.563,2.5250981936;
            1401.064,2.6032975728; 1401.564,2.5744872752; 1402.064,2.6485708976;
            1402.564,2.6321078704; 1403.064,2.6732654384; 1403.565,2.7391175472;
            1404.063,2.7391175472; 1404.565,2.7761593584; 1405.065,2.7679278448;
            1405.563,2.8132011696; 1406.064,2.8378957104; 1406.565,2.8914005488;
            1407.065,2.9037478192; 1407.564,2.8996320624; 1408.064,2.9613684144;
            1408.564,2.9449053872; 1409.064,2.969599928; 1409.561,2.9778314416;
            1410.064,3.0066417392; 1410.563,3.0395677936; 1411.065,3.0560308208;
            1411.564,3.0642623344; 1412.066,3.1589247408; 1412.561,3.1877350384;
            1413.064,3.2124295792; 1413.565,3.2823974448; 1414.062,3.3276707696;
            1414.564,3.319439256; 1415.064,3.3482495536; 1415.563,3.3852913648;
            1416.063,3.422333176; 1416.564,3.3976386352; 1417.063,3.4346804464;
            1417.563,3.4470277168; 1418.063,3.484069528; 1418.563,3.5293428528;
            1419.063,3.5416901232; 1419.564,3.5746161776; 1420.065,3.5211113392;
            1420.563,3.5293428528; 1421.065,3.5293428528; 1421.563,3.566384664;
            1422.064,3.607542232; 1422.564,3.6486998; 1423.065,3.710436152;
            1423.561,3.6322367728; 1424.065,3.6939731248; 1424.565,3.6816258544;
            1425.061,3.6939731248; 1425.565,3.6980888816; 1426.064,3.6857416112;
            1426.563,3.6733943408; 1427.064,3.6610470704; 1427.563,3.6528155568;
            1428.062,3.689857368; 1428.565,3.6445840432; 1429.063,3.6775100976;
            1429.561,3.6157737456; 1430.062,3.6528155568; 1430.565,3.6610470704;
            1431.062,3.6610470704; 1431.561,3.6157737456; 1432.063,3.6116579888;
            1432.564,3.6486998; 1433.064,3.6528155568; 1433.562,3.6857416112;
            1434.062,3.7392464496; 1434.56,3.6198895024; 1435.063,3.6240052592;
            1435.564,3.586963448; 1436.064,3.54580588; 1436.562,3.5087640688;
            1437.064,3.5211113392; 1437.564,3.5169955824; 1438.064,3.4511434736;
            1438.563,3.4346804464; 1439.063,3.4099859056; 1439.565,3.4470277168;
            1440.065,3.4511434736; 1440.564,3.3523653104; 1441.064,3.3112077424;
            1441.564,3.298860472; 1442.065,3.278281688; 1442.563,3.3359022832;
            1443.064,3.2618186608; 1443.565,3.2494713904; 1444.064,3.23712412;
            1444.564,3.2947447152; 1445.065,3.34001804; 1445.565,3.2947447152;
            1446.062,3.2453556336; 1446.563,3.2823974448; 1447.065,3.2330083632;
            1447.564,3.1301144432; 1448.065,3.1795035248; 1448.564,3.0560308208;
            1449.064,3.093072632; 1449.564,3.0148732528; 1450.063,3.0683780912;
            1450.561,3.0189890096; 1451.064,2.9654841712; 1451.565,2.9819471984;
            1452.064,2.8996320624; 1452.564,2.866706008; 1453.065,2.887284792;
            1453.563,2.8749375216; 1454.065,2.887284792; 1454.566,2.8378957104;
            1455.065,2.8708217648; 1455.562,2.8296641968; 1456.064,2.8708217648;
            1456.563,2.8132011696; 1457.064,2.8008538992; 1457.564,2.8132011696;
            1458.064,2.8090854128; 1458.564,2.804969656; 1459.064,2.7473490608;
            1459.564,2.8008538992; 1460.064,2.7679278448; 1460.562,2.7473490608;
            1461.065,2.7391175472; 1461.565,2.702075736; 1462.064,2.6979599792;
            1462.563,2.7103072496; 1463.062,2.6897284656; 1463.565,2.6897284656;
            1464.063,2.6938442224; 1464.564,2.7350017904; 1465.066,2.7473490608;
            1465.563,2.7144230064; 1466.064,2.72265452; 1466.563,2.7267702768;
            1467.063,2.743233304; 1467.564,2.6773811952; 1468.062,2.7514648176;
            1468.564,2.702075736; 1469.065,2.7308860336; 1469.561,2.6732654384;
            1470.063,2.6938442224; 1470.565,2.6568024112; 1471.065,2.6897284656;
            1471.564,2.6897284656; 1472.063,2.6526866544; 1472.565,2.6568024112;
            1473.061,2.6362236272; 1473.564,2.6074133296; 1474.062,2.6568024112;
            1474.564,2.6362236272; 1475.064,2.5868345456; 1475.564,2.660918168;
            1476.064,2.5950660592; 1476.565,2.6197606; 1477.063,2.640339384;
            1477.565,2.6197606; 1478.065,2.6074133296; 1478.565,2.537445464;
            1479.062,2.5333297072; 1479.56,2.5127509232; 1480.062,2.5456769776;
            1480.564,2.6197606; 1481.064,2.5127509232; 1481.563,2.5539084912;
            1482.065,2.5621400048; 1482.564,2.5497927344; 1483.064,2.6485708976;
            1483.563,2.5621400048; 1484.062,2.5127509232; 1484.566,2.5621400048;
            1485.064,2.51686668; 1485.565,2.4633618416; 1486.063,2.5333297072;
            1486.563,2.4674775984; 1487.062,2.5250981936; 1487.565,2.5662557616;
            1488.065,2.5456769776; 1488.564,2.578603032; 1489.064,2.5415612208;
            1489.564,2.5333297072; 1490.062,2.558024248; 1490.566,2.5456769776;
            1491.064,2.5415612208; 1491.56,2.5744872752; 1492.064,2.5909503024;
            1492.562,2.558024248; 1493.066,2.6074133296; 1493.566,2.5868345456;
            1494.063,2.6115290864; 1494.564,2.5621400048; 1495.063,2.6732654384;
            1495.565,2.6444551408; 1496.062,2.6485708976; 1496.565,2.6032975728;
            1497.062,2.6856127088; 1497.564,2.660918168; 1498.064,2.6526866544;
            1498.563,2.6691496816; 1499.061,2.6979599792; 1499.564,2.7144230064;
            1500.063,2.6732654384; 1500.565,2.7555805744; 1501.064,2.6938442224;
            1501.563,2.763812088; 1502.063,2.7761593584; 1502.561,2.804969656;
            1503.064,2.7967381424; 1503.565,2.7514648176; 1504.062,2.7885066288;
            1504.563,2.8296641968; 1505.064,2.784390872; 1505.564,2.846127224;
            1506.064,2.8090854128; 1506.564,2.8955163056; 1507.064,2.8378957104;
            1507.564,2.8543587376; 1508.064,2.8296641968; 1508.564,2.866706008;
            1509.061,2.8914005488; 1509.564,2.8790532784; 1510.063,2.887284792;
            1510.564,2.8914005488; 1511.065,2.8996320624; 1511.562,2.8708217648;
            1512.065,2.8955163056; 1512.563,2.907863576; 1513.063,2.8955163056;
            1513.563,2.9243266032; 1514.061,2.9325581168; 1514.564,2.8790532784;
            1515.064,2.9160950896; 1515.564,2.9407896304; 1516.065,3.0189890096;
            1516.564,3.03133628; 1517.065,2.990178712; 1517.566,2.907863576;
            1518.065,2.9654841712; 1518.564,2.9942944688; 1519.062,2.9778314416;
            1519.563,3.0272205232; 1520.063,2.9942944688; 1520.565,3.0395677936;
            1521.066,3.0066417392; 1521.564,3.0189890096; 1522.065,3.0642623344;
            1522.563,3.0189890096; 1523.062,3.0477993072; 1523.563,3.0477993072;
            1524.062,3.0436835504; 1524.563,3.0683780912; 1525.064,3.0848411184;
            1525.565,3.0889568752; 1526.065,3.0848411184; 1526.563,3.0766096048;
            1527.063,3.072493848; 1527.563,3.0848411184; 1528.062,3.0889568752;
            1528.562,3.051915064; 1529.06,3.1054199024; 1529.565,3.0807253616;
            1530.064,3.1218829296; 1530.564,3.1054199024; 1531.064,3.0477993072;
            1531.564,3.1424617136; 1532.064,3.1054199024; 1532.562,3.1630404976;
            1533.063,3.1054199024; 1533.565,3.1095356592; 1534.061,3.0642623344;
            1534.563,3.1218829296; 1535.064,3.0642623344; 1535.565,3.113651416;
            1536.064,3.0642623344; 1536.564,3.093072632; 1537.062,3.0766096048;
            1537.564,3.0601465776; 1538.063,3.0848411184; 1538.565,3.0971883888;
            1539.061,3.0642623344; 1539.566,3.0889568752; 1540.063,3.0148732528;
            1540.566,3.0683780912; 1541.062,3.0231047664; 1541.563,3.0560308208;
            1542.063,3.0766096048; 1542.563,3.0889568752; 1543.063,3.0642623344;
            1543.565,3.051915064; 1544.062,3.0601465776; 1544.563,3.0231047664;
            1545.062,3.0395677936; 1545.563,3.0395677936; 1546.064,3.0148732528;
            1546.564,3.0066417392; 1547.063,3.0272205232; 1547.561,3.0395677936;
            1548.061,3.0231047664; 1548.562,2.9984102256; 1549.062,3.03133628;
            1549.563,3.0025259824; 1550.062,2.9778314416; 1550.564,3.010757496;
            1551.064,2.9449053872; 1551.563,2.9737156848; 1552.063,2.9860629552;
            1552.565,2.9942944688; 1553.062,2.9243266032; 1553.56,2.9572526576;
            1554.062,2.9202108464; 1554.562,2.9202108464; 1555.062,2.8914005488;
            1555.565,2.9119793328; 1556.062,2.9160950896; 1556.561,2.8955163056;
            1557.062,2.907863576; 1557.565,2.8790532784; 1558.063,2.907863576;
            1558.563,2.8708217648; 1559.061,2.92844236; 1559.563,2.8790532784;
            1560.064,2.8955163056; 1560.564,2.8749375216; 1561.062,2.9449053872;
            1561.564,2.9202108464; 1562.064,2.9654841712; 1562.562,2.9366738736;
            1563.065,2.9407896304; 1563.562,2.907863576; 1564.064,2.949021144;
            1564.564,2.9037478192; 1565.065,2.9325581168; 1565.563,2.92844236;
            1566.062,2.949021144; 1566.564,2.92844236; 1567.062,2.92844236;
            1567.564,2.9243266032; 1568.063,2.8955163056; 1568.561,2.9531369008;
            1569.065,2.907863576; 1569.563,2.949021144; 1570.064,2.8955163056;
            1570.563,2.907863576; 1571.063,2.907863576; 1571.563,2.92844236;
            1572.061,2.9243266032; 1572.564,2.9243266032; 1573.065,2.9160950896;
            1573.564,2.969599928; 1574.062,2.9119793328; 1574.563,2.9449053872;
            1575.061,2.9119793328; 1575.561,2.907863576; 1576.062,2.92844236;
            1576.563,2.9202108464; 1577.064,2.9613684144; 1577.564,2.8996320624;
            1578.064,2.9778314416; 1578.564,2.92844236; 1579.062,3.010757496;
            1579.563,2.9613684144; 1580.064,2.9325581168; 1580.564,3.0148732528;
            1581.064,3.0231047664; 1581.564,3.0066417392; 1582.062,2.9407896304;
            1582.564,2.9654841712; 1583.063,2.9737156848; 1583.562,2.9325581168;
            1584.064,2.9737156848; 1584.564,2.990178712; 1585.065,3.0025259824;
            1585.563,2.9407896304; 1586.064,3.0642623344; 1586.564,3.0025259824;
            1587.065,2.9572526576; 1587.564,3.0395677936; 1588.063,2.9654841712;
            1588.564,2.9737156848; 1589.063,2.9243266032; 1589.564,2.9243266032;
            1590.063,2.92844236; 1590.565,2.8996320624; 1591.065,2.9243266032;
            1591.566,2.9037478192; 1592.065,2.9160950896; 1592.563,2.9366738736;
            1593.063,2.9407896304; 1593.565,2.9613684144; 1594.062,2.9407896304;
            1594.566,2.9737156848; 1595.063,2.9572526576; 1595.563,3.0066417392;
            1596.065,2.9613684144; 1596.563,3.0025259824; 1597.061,2.9572526576;
            1597.565,2.990178712; 1598.064,3.0231047664; 1598.566,2.9819471984;
            1599.061,2.9531369008; 1599.564,2.9819471984; 1600.064,2.9984102256;
            1600.564,3.03133628; 1601.065,2.9654841712; 1601.564,2.990178712;
            1602.065,2.9407896304; 1602.564,2.9654841712; 1603.063,2.9407896304;
            1603.564,2.9037478192; 1604.062,2.9531369008; 1604.564,2.9449053872;
            1605.065,2.9243266032; 1605.564,2.8955163056; 1606.066,2.9160950896;
            1606.566,2.8749375216; 1607.064,2.990178712; 1607.565,2.9860629552;
            1608.065,2.9613684144; 1608.562,2.969599928; 1609.065,2.9572526576;
            1609.563,2.949021144; 1610.063,2.9984102256; 1610.564,3.0025259824;
            1611.065,2.9737156848; 1611.565,2.9942944688; 1612.063,3.0354520368;
            1612.565,2.9819471984; 1613.061,3.0560308208; 1613.565,2.969599928;
            1614.064,3.0066417392; 1614.564,2.9572526576; 1615.064,2.9531369008;
            1615.564,3.0066417392; 1616.063,2.9654841712; 1616.563,2.9778314416;
            1617.061,3.0148732528; 1617.563,2.990178712; 1618.063,3.0148732528;
            1618.562,2.9984102256; 1619.063,2.990178712; 1619.565,2.9984102256;
            1620.065,2.990178712; 1620.565,2.9737156848; 1621.061,2.9942944688;
            1621.562,3.051915064; 1622.065,3.0189890096; 1622.563,3.0601465776;
            1623.062,3.0848411184; 1623.564,3.051915064; 1624.064,3.0971883888;
            1624.561,3.0272205232; 1625.063,3.0601465776; 1625.564,3.0231047664;
            1626.065,3.0354520368; 1626.564,3.051915064; 1627.062,3.0436835504;
            1627.564,3.051915064; 1628.062,3.051915064; 1628.565,3.0971883888;
            1629.064,3.1259986864; 1629.565,3.1177671728; 1630.063,3.0971883888;
            1630.565,3.0807253616; 1631.061,3.0848411184; 1631.566,3.1095356592;
            1632.065,3.1013041456; 1632.564,3.1054199024; 1633.064,3.1095356592;
            1633.564,3.113651416; 1634.064,3.0354520368; 1634.563,3.051915064;
            1635.064,3.0436835504; 1635.565,3.0066417392; 1636.064,3.0436835504;
            1636.562,3.0272205232; 1637.065,2.9942944688; 1637.565,3.0148732528;
            1638.061,2.9531369008; 1638.565,2.9984102256; 1639.065,2.9778314416;
            1639.564,2.9202108464; 1640.066,2.9984102256; 1640.565,2.9407896304;
            1641.064,2.9654841712; 1641.565,2.9942944688; 1642.064,2.9778314416;
            1642.564,3.0272205232; 1643.062,2.990178712; 1643.567,2.9942944688;
            1644.064,2.9860629552; 1644.564,2.9778314416; 1645.065,2.9984102256;
            1645.564,3.0025259824; 1646.065,2.990178712; 1646.565,3.0148732528;
            1647.064,3.0231047664; 1647.563,3.0066417392; 1648.065,2.9613684144;
            1648.565,2.9613684144; 1649.064,2.9654841712; 1649.563,2.9984102256;
            1650.063,2.9572526576; 1650.565,3.0766096048; 1651.065,3.0231047664;
            1651.564,2.9860629552; 1652.066,2.9778314416; 1652.565,2.9860629552;
            1653.064,2.9778314416; 1653.565,2.9654841712; 1654.061,3.0436835504;
            1654.561,3.0560308208; 1655.062,3.0889568752; 1655.561,3.1054199024;
            1656.061,3.113651416; 1656.563,3.1095356592; 1657.062,3.1383459568;
            1657.564,3.1177671728; 1658.065,3.113651416; 1658.566,3.0848411184;
            1659.065,3.0971883888; 1659.562,3.0272205232; 1660.062,3.0560308208;
            1660.563,3.0395677936; 1661.061,3.010757496; 1661.564,3.0231047664;
            1662.064,3.0436835504; 1662.566,3.0477993072; 1663.063,3.072493848;
            1663.563,3.0848411184; 1664.064,3.0148732528; 1664.561,3.0477993072;
            1665.065,3.0148732528; 1665.564,3.010757496; 1666.064,3.0231047664;
            1666.563,2.9984102256; 1667.065,3.0272205232; 1667.565,3.0477993072;
            1668.065,3.0354520368; 1668.562,3.0477993072; 1669.062,3.010757496;
            1669.563,3.0683780912; 1670.066,3.03133628; 1670.564,2.9942944688;
            1671.063,3.1013041456; 1671.565,3.051915064; 1672.064,2.9984102256;
            1672.565,3.0477993072; 1673.063,3.072493848; 1673.561,3.0601465776;
            1674.063,3.1054199024; 1674.563,3.072493848; 1675.063,3.03133628;
            1675.564,3.0148732528; 1676.065,3.0025259824; 1676.565,3.03133628;
            1677.063,3.0436835504; 1677.563,3.0971883888; 1678.064,3.1013041456;
            1678.564,3.0889568752; 1679.066,3.0766096048; 1679.563,3.0683780912;
            1680.064,3.0436835504; 1680.56,3.1218829296; 1681.063,3.1013041456;
            1681.561,3.0436835504; 1682.062,3.0683780912; 1682.565,3.0971883888;
            1683.062,3.1177671728; 1683.564,3.093072632; 1684.065,3.1054199024;
            1684.564,3.0642623344; 1685.065,3.03133628; 1685.565,3.0148732528;
            1686.065,3.051915064; 1686.563,2.9942944688; 1687.065,3.0025259824;
            1687.564,2.9613684144; 1688.064,2.9613684144; 1688.564,2.969599928;
            1689.065,2.9366738736; 1689.565,2.9860629552; 1690.064,2.9160950896;
            1690.564,2.92844236; 1691.065,2.969599928; 1691.564,2.9572526576;
            1692.067,2.9366738736; 1692.565,2.9243266032; 1693.062,2.9737156848;
            1693.565,2.9860629552; 1694.06,2.9366738736; 1694.565,2.9572526576;
            1695.065,2.9119793328; 1695.562,2.9737156848; 1696.064,2.9613684144;
            1696.566,2.969599928; 1697.064,2.9778314416; 1697.564,2.9572526576;
            1698.063,2.9984102256; 1698.562,2.9737156848; 1699.064,3.010757496;
            1699.565,2.9572526576; 1700.066,3.0025259824; 1700.562,3.03133628;
            1701.063,2.9860629552; 1701.564,3.0231047664; 1702.064,2.9984102256;
            1702.561,3.03133628; 1703.066,3.0436835504; 1703.565,3.0395677936;
            1704.065,3.093072632; 1704.564,3.0601465776; 1705.063,3.1095356592;
            1705.564,3.0889568752; 1706.062,3.1301144432; 1706.563,3.1877350384;
            1707.063,3.2288926064; 1707.565,3.1465774704; 1708.065,3.1301144432;
            1708.565,3.1259986864; 1709.065,3.1589247408; 1709.563,3.1054199024;
            1710.061,3.0477993072; 1710.564,3.0848411184; 1711.064,3.1218829296;
            1711.563,3.1259986864; 1712.063,3.0601465776; 1712.564,3.0971883888;
            1713.063,3.093072632; 1713.564,3.0807253616; 1714.064,3.1177671728;
            1714.565,3.1095356592; 1715.064,3.0560308208; 1715.566,3.113651416;
            1716.066,3.0683780912; 1716.564,3.0272205232; 1717.061,3.0354520368;
            1717.565,3.0354520368; 1718.062,3.0560308208; 1718.563,3.0436835504;
            1719.064,3.051915064; 1719.562,3.0477993072; 1720.065,3.0766096048;
            1720.565,3.051915064; 1721.065,3.072493848; 1721.564,3.0889568752;
            1722.065,3.0642623344; 1722.564,3.113651416; 1723.065,3.0560308208;
            1723.565,3.0601465776; 1724.065,3.0683780912; 1724.561,3.051915064;
            1725.064,3.072493848; 1725.564,3.0807253616; 1726.065,3.0807253616;
            1726.565,3.0848411184; 1727.064,3.0395677936; 1727.563,3.072493848;
            1728.064,3.1013041456; 1728.563,3.0683780912; 1729.065,3.0601465776;
            1729.564,3.0889568752; 1730.064,3.113651416; 1730.564,3.0889568752;
            1731.064,3.0807253616; 1731.564,3.1013041456; 1732.066,3.0807253616;
            1732.563,3.1177671728; 1733.064,3.0683780912; 1733.564,3.0560308208;
            1734.062,3.0971883888; 1734.562,3.113651416; 1735.063,3.0889568752;
            1735.563,3.1013041456; 1736.063,3.0766096048; 1736.565,3.1177671728;
            1737.064,3.0889568752; 1737.563,3.0683780912; 1738.063,3.0807253616;
            1738.565,3.0601465776; 1739.064,3.0807253616; 1739.562,3.072493848;
            1740.065,3.0889568752; 1740.561,3.093072632; 1741.066,3.0189890096;
            1741.564,3.1054199024; 1742.064,3.1506932272; 1742.563,3.1589247408;
            1743.062,3.1259986864; 1743.564,3.0601465776; 1744.063,3.0560308208;
            1744.562,3.093072632; 1745.063,3.113651416; 1745.564,3.0560308208;
            1746.065,3.0560308208; 1746.561,3.0807253616; 1747.062,3.1342302;
            1747.563,3.0683780912; 1748.065,3.1095356592; 1748.564,3.0766096048;
            1749.063,3.0807253616; 1749.562,3.1177671728; 1750.064,3.113651416;
            1750.564,3.0231047664; 1751.065,3.0848411184; 1751.566,3.0477993072;
            1752.064,3.072493848; 1752.565,3.0642623344; 1753.064,3.0683780912;
            1753.565,3.0848411184; 1754.066,3.0477993072; 1754.562,3.0807253616;
            1755.064,3.0436835504; 1755.563,3.0436835504; 1756.063,3.0354520368;
            1756.565,3.1177671728; 1757.065,3.0436835504; 1757.565,3.0889568752;
            1758.064,3.010757496; 1758.564,3.0395677936; 1759.063,3.0354520368;
            1759.563,3.0066417392; 1760.066,3.0354520368; 1760.563,3.1177671728;
            1761.065,3.0272205232; 1761.566,3.0848411184; 1762.063,3.0395677936;
            1762.564,3.0766096048; 1763.064,3.0231047664; 1763.563,3.072493848;
            1764.065,3.0642623344; 1764.562,3.0436835504; 1765.063,3.03133628;
            1765.565,3.1301144432; 1766.064,3.0395677936; 1766.563,3.0560308208;
            1767.065,3.0354520368; 1767.564,3.0231047664; 1768.065,3.051915064;
            1768.564,3.0436835504; 1769.064,3.072493848; 1769.562,3.1054199024;
            1770.065,3.093072632; 1770.562,3.0807253616; 1771.065,3.1013041456;
            1771.563,3.1177671728; 1772.064,3.1671562544; 1772.563,3.1301144432;
            1773.063,3.2124295792; 1773.564,3.1836192816; 1774.064,3.1712720112;
            1774.561,3.2083138224; 1775.064,3.1630404976; 1775.56,3.1795035248;
            1776.065,3.1301144432; 1776.564,3.1506932272; 1777.065,3.1095356592;
            1777.564,3.1177671728; 1778.066,3.1177671728; 1778.564,3.0766096048;
            1779.064,3.072493848; 1779.563,3.051915064; 1780.063,3.0766096048;
            1780.563,3.0848411184; 1781.064,3.0889568752; 1781.564,3.0642623344;
            1782.065,3.072493848; 1782.563,3.0807253616; 1783.063,3.0560308208;
            1783.563,3.072493848; 1784.066,3.093072632; 1784.562,3.0189890096;
            1785.066,3.051915064; 1785.564,3.0066417392; 1786.064,3.0066417392;
            1786.563,2.9778314416; 1787.063,3.0148732528; 1787.564,3.0436835504;
            1788.065,3.0272205232; 1788.564,3.072493848; 1789.064,3.051915064;
            1789.564,3.051915064; 1790.065,3.1054199024; 1790.564,3.051915064;
            1791.064,3.0642623344; 1791.564,3.0683780912; 1792.062,3.0066417392;
            1792.564,3.1506932272; 1793.063,3.0601465776; 1793.564,3.0683780912;
            1794.063,3.0560308208; 1794.562,3.0025259824; 1795.064,2.9984102256;
            1795.563,3.0848411184; 1796.064,3.03133628; 1796.565,3.0477993072;
            1797.064,3.0189890096; 1797.564,3.03133628; 1798.064,3.0848411184;
            1798.564,3.03133628; 1799.065,3.03133628; 1799.566,3.010757496;
            1800.062,2.9778314416; 1800.564,3.0601465776; 1801.063,3.0354520368;
            1801.566,3.0477993072; 1802.065,3.0189890096; 1802.565,3.0354520368;
            1803.065,2.9942944688; 1803.566,3.0272205232; 1804.063,3.072493848;
            1804.564,3.0477993072; 1805.065,3.0436835504; 1805.566,3.051915064;
            1806.065,3.0642623344; 1806.564,3.0395677936; 1807.064,3.051915064;
            1807.562,3.0272205232; 1808.063,3.010757496; 1808.563,3.0477993072;
            1809.065,3.0148732528; 1809.566,3.0848411184; 1810.065,3.0889568752;
            1810.564,3.0560308208; 1811.063,3.0766096048; 1811.565,3.0601465776;
            1812.066,3.093072632; 1812.565,3.1054199024; 1813.065,3.1013041456;
            1813.565,3.1013041456; 1814.063,3.1177671728; 1814.566,3.1013041456;
            1815.065,3.051915064; 1815.564,3.0601465776; 1816.066,3.0848411184;
            1816.565,3.093072632; 1817.065,3.1259986864; 1817.565,3.154808984;
            1818.065,3.1054199024; 1818.564,3.051915064; 1819.064,3.0848411184;
            1819.564,3.1095356592; 1820.066,3.1465774704; 1820.563,3.1259986864;
            1821.065,3.1218829296; 1821.565,3.1301144432; 1822.064,3.113651416;
            1822.565,3.1836192816; 1823.064,3.1671562544; 1823.564,3.1342302;
            1824.064,3.0971883888; 1824.565,3.093072632; 1825.064,3.0807253616;
            1825.565,3.1054199024; 1826.065,3.1259986864; 1826.565,3.1177671728;
            1827.065,3.0683780912; 1827.566,3.093072632; 1828.065,3.0766096048;
            1828.566,2.990178712; 1829.064,3.0148732528; 1829.565,3.0766096048;
            1830.065,3.0683780912; 1830.564,3.1301144432; 1831.065,3.1301144432;
            1831.565,3.093072632; 1832.064,3.1836192816; 1832.563,3.1177671728;
            1833.064,3.1342302; 1833.564,3.1177671728; 1834.062,3.1177671728;
            1834.562,3.1342302; 1835.065,3.0971883888; 1835.563,3.113651416;
            1836.065,3.1054199024; 1836.565,3.0971883888; 1837.064,3.0807253616;
            1837.564,3.0848411184; 1838.064,3.0683780912; 1838.564,3.0889568752;
            1839.064,3.113651416; 1839.565,3.0848411184; 1840.067,3.113651416;
            1840.565,3.1259986864; 1841.066,3.1506932272; 1841.564,3.1218829296;
            1842.065,3.1383459568; 1842.566,3.1465774704; 1843.064,3.1424617136;
            1843.563,3.1630404976; 1844.066,3.0848411184; 1844.566,3.1424617136;
            1845.065,3.1671562544; 1845.563,3.175387768; 1846.065,3.216545336;
            1846.565,3.2494713904; 1847.064,3.2288926064; 1847.566,3.2083138224;
            1848.066,3.216545336; 1848.566,3.2041980656; 1849.066,3.1877350384;
            1849.566,3.1836192816; 1850.066,3.1877350384; 1850.565,3.154808984;
            1851.065,3.1218829296; 1851.565,3.0971883888; 1852.064,3.1342302;
            1852.564,3.0807253616; 1853.065,3.0766096048; 1853.565,3.093072632;
            1854.065,3.0848411184; 1854.565,3.093072632; 1855.065,3.0848411184;
            1855.565,3.1177671728; 1856.061,3.1013041456; 1856.563,3.1342302;
            1857.064,3.1013041456; 1857.565,3.1054199024; 1858.065,3.1342302;
            1858.565,3.093072632; 1859.066,3.1259986864; 1859.564,3.0807253616;
            1860.064,3.0971883888; 1860.565,3.0642623344; 1861.064,3.0683780912;
            1861.565,3.1054199024; 1862.064,3.072493848; 1862.565,3.0642623344;
            1863.062,3.1218829296; 1863.565,3.113651416; 1864.061,3.0601465776;
            1864.563,3.113651416; 1865.063,3.0971883888; 1865.563,3.0683780912;
            1866.062,3.0807253616; 1866.566,3.1342302; 1867.065,3.0189890096;
            1867.565,3.0066417392; 1868.065,3.0395677936; 1868.564,3.1013041456;
            1869.064,3.0807253616; 1869.564,3.1013041456; 1870.066,3.0560308208;
            1870.566,2.9942944688; 1871.066,3.1013041456; 1871.563,3.1054199024;
            1872.063,3.0231047664; 1872.566,3.0807253616; 1873.065,3.113651416;
            1873.565,3.0889568752; 1874.062,3.0477993072; 1874.564,3.0272205232;
            1875.065,3.051915064; 1875.565,3.0642623344; 1876.066,3.072493848;
            1876.566,3.093072632; 1877.063,3.0395677936; 1877.563,3.0889568752;
            1878.064,3.0642623344; 1878.564,3.0395677936; 1879.063,3.0642623344;
            1879.562,3.0354520368; 1880.065,3.0766096048; 1880.563,3.0189890096;
            1881.062,3.0848411184; 1881.564,3.0971883888; 1882.064,3.0642623344;
            1882.565,3.0354520368; 1883.064,3.0848411184; 1883.565,3.0601465776;
            1884.065,3.0642623344; 1884.565,3.0807253616; 1885.064,3.0889568752;
            1885.562,3.1095356592; 1886.063,3.0683780912; 1886.565,3.0889568752;
            1887.066,3.0971883888; 1887.564,3.0642623344; 1888.064,3.0766096048;
            1888.565,3.0231047664; 1889.065,3.0601465776; 1889.564,3.1054199024;
            1890.063,3.051915064; 1890.564,3.0642623344; 1891.064,3.0642623344;
            1891.565,3.0477993072; 1892.064,3.0683780912; 1892.564,3.051915064;
            1893.065,3.1054199024; 1893.563,3.0066417392; 1894.063,3.0683780912;
            1894.562,3.0560308208; 1895.064,3.0560308208; 1895.565,3.03133628;
            1896.065,3.0971883888; 1896.565,3.0436835504; 1897.066,3.0601465776;
            1897.566,3.0395677936; 1898.063,3.051915064; 1898.563,3.0807253616;
            1899.064,3.0642623344; 1899.564,3.0889568752; 1900.065,3.072493848;
            1900.564,3.093072632; 1901.065,3.0807253616; 1901.565,3.093072632;
            1902.065,3.093072632; 1902.563,3.0971883888; 1903.063,3.0971883888;
            1903.565,3.1342302; 1904.061,3.0683780912; 1904.564,3.0354520368;
            1905.065,3.1013041456; 1905.565,3.1259986864; 1906.063,3.072493848;
            1906.565,3.072493848; 1907.066,3.093072632; 1907.564,3.0848411184;
            1908.066,3.1177671728; 1908.565,3.0807253616; 1909.065,3.0971883888;
            1909.565,3.1259986864; 1910.065,3.1259986864; 1910.566,3.1054199024;
            1911.065,3.1630404976; 1911.565,3.113651416; 1912.065,3.1506932272;
            1912.565,3.1177671728; 1913.064,3.1630404976; 1913.564,3.154808984;
            1914.064,3.1506932272; 1914.564,3.1218829296; 1915.066,3.1589247408;
            1915.562,3.1836192816; 1916.063,3.1424617136; 1916.565,3.1630404976;
            1917.064,3.154808984; 1917.565,3.2083138224; 1918.065,3.1630404976;
            1918.564,3.1712720112; 1919.063,3.1877350384; 1919.564,3.1795035248;
            1920.064,3.1465774704; 1920.566,3.2124295792; 1921.064,3.2124295792;
            1921.565,3.216545336; 1922.063,3.1712720112; 1922.564,3.0889568752;
            1923.065,3.1301144432; 1923.565,3.1177671728; 1924.062,3.1054199024;
            1924.564,3.175387768; 1925.06,3.1424617136; 1925.565,3.1013041456;
            1926.064,3.1630404976; 1926.564,3.113651416; 1927.065,3.1506932272;
            1927.565,3.1177671728; 1928.062,3.1589247408; 1928.564,3.1342302;
            1929.063,3.1177671728; 1929.565,3.1383459568; 1930.064,3.1465774704;
            1930.565,3.1506932272; 1931.064,3.113651416; 1931.563,3.0889568752;
            1932.063,3.1465774704; 1932.565,3.0848411184; 1933.065,3.1259986864;
            1933.562,3.0848411184; 1934.065,3.0560308208; 1934.563,3.072493848;
            1935.062,3.0766096048; 1935.565,3.0560308208; 1936.062,3.0148732528;
            1936.564,3.0066417392; 1937.065,3.0272205232; 1937.565,3.051915064;
            1938.065,3.0272205232; 1938.567,3.03133628; 1939.065,3.051915064;
            1939.563,3.0766096048; 1940.065,3.0807253616; 1940.566,3.0601465776;
            1941.063,3.1259986864; 1941.564,3.0683780912; 1942.066,3.1301144432;
            1942.565,3.1095356592; 1943.066,3.1013041456; 1943.565,3.072493848;
            1944.065,3.1095356592; 1944.562,3.0683780912; 1945.065,3.1095356592;
            1945.564,3.0889568752; 1946.062,3.1095356592; 1946.565,3.1630404976;
            1947.062,3.0971883888; 1947.563,3.1383459568; 1948.065,3.1424617136;
            1948.564,3.1589247408; 1949.061,3.1054199024; 1949.565,3.2041980656;
            1950.062,3.1836192816; 1950.563,3.278281688; 1951.065,3.2618186608;
            1951.565,3.216545336; 1952.066,3.23712412; 1952.563,3.1836192816;
            1953.065,3.1795035248; 1953.565,3.1918507952; 1954.065,3.1877350384;
            1954.564,3.154808984; 1955.065,3.1301144432; 1955.566,3.1506932272;
            1956.065,3.0766096048; 1956.565,3.1013041456; 1957.065,3.0971883888;
            1957.564,3.0971883888; 1958.064,3.1589247408; 1958.563,3.1259986864;
            1959.063,3.1095356592; 1959.565,3.1342302; 1960.065,3.1506932272;
            1960.564,3.1177671728; 1961.063,3.1671562544; 1961.565,3.1259986864;
            1962.063,3.1342302; 1962.562,3.1589247408; 1963.064,3.1465774704;
            1963.564,3.2000823088; 1964.065,3.1424617136; 1964.564,3.1383459568;
            1965.062,3.1301144432; 1965.562,3.1506932272; 1966.064,3.1465774704;
            1966.564,3.1013041456; 1967.065,3.0889568752; 1967.564,3.0971883888;
            1968.065,3.0848411184; 1968.566,3.0766096048; 1969.065,3.1506932272;
            1969.563,3.1712720112; 1970.064,3.2000823088; 1970.562,3.1177671728;
            1971.065,3.1465774704; 1971.564,3.1836192816; 1972.063,3.175387768;
            1972.565,3.1465774704; 1973.061,3.1877350384; 1973.564,3.2124295792;
            1974.065,3.2206610928; 1974.566,3.195966552; 1975.064,3.1589247408;
            1975.565,3.2330083632; 1976.064,3.2083138224; 1976.564,3.175387768;
            1977.065,3.1054199024; 1977.564,3.154808984; 1978.064,3.1177671728;
            1978.564,3.1465774704; 1979.066,3.0971883888; 1979.564,3.072493848;
            1980.066,3.093072632; 1980.565,3.1301144432; 1981.065,3.1013041456;
            1981.562,3.1218829296; 1982.065,3.0601465776; 1982.565,3.113651416;
            1983.065,3.1054199024; 1983.564,3.072493848; 1984.066,3.0848411184;
            1984.565,3.0560308208; 1985.065,3.1095356592; 1985.565,3.03133628;
            1986.065,3.1013041456; 1986.566,3.0807253616; 1987.066,3.1095356592;
            1987.565,3.1054199024; 1988.066,3.0889568752; 1988.565,3.0766096048;
            1989.065,3.0807253616; 1989.565,3.0889568752; 1990.065,3.072493848;
            1990.566,3.1177671728; 1991.065,3.154808984; 1991.565,3.2206610928;
            1992.063,3.2618186608; 1992.565,3.2618186608; 1993.066,3.2330083632;
            1993.567,3.2000823088; 1994.064,3.1877350384; 1994.562,3.1918507952;
            1995.065,3.1218829296; 1995.566,3.1383459568; 1996.064,3.093072632;
            1996.564,3.1383459568; 1997.065,3.0560308208; 1997.566,3.1465774704;
            1998.064,3.175387768; 1998.562,3.1795035248; 1999.064,3.2288926064;
            1999.565,3.1918507952; 2000.063,3.1259986864; 2000.566,3.1383459568;
            2001.064,3.1177671728; 2001.563,3.1218829296; 2002.065,3.1301144432;
            2002.565,3.1383459568; 2003.065,3.0971883888; 2003.564,3.1177671728;
            2004.066,3.113651416; 2004.562,3.1671562544; 2005.063,3.1342302;
            2005.564,3.1671562544; 2006.066,3.1589247408; 2006.566,3.175387768;
            2007.064,3.1712720112; 2007.566,3.2206610928; 2008.065,3.2247768496;
            2008.563,3.1877350384; 2009.066,3.1259986864; 2009.565,3.1795035248;
            2010.062,3.2288926064; 2010.563,3.2206610928; 2011.063,3.2041980656;
            2011.564,3.1095356592; 2012.067,3.1095356592; 2012.565,3.1095356592;
            2013.062,3.1383459568; 2013.567,3.1218829296; 2014.065,3.0971883888;
            2014.566,3.0807253616; 2015.063,3.0642623344; 2015.566,3.0395677936;
            2016.064,3.0848411184; 2016.564,3.113651416; 2017.067,3.0560308208;
            2017.565,3.1218829296; 2018.065,3.1095356592; 2018.565,3.072493848;
            2019.066,3.1342302; 2019.566,3.1218829296; 2020.061,3.1383459568;
            2020.565,3.1795035248; 2021.064,3.175387768; 2021.566,3.1301144432;
            2022.065,3.0807253616; 2022.566,3.1177671728; 2023.065,3.093072632;
            2023.562,3.2041980656; 2024.065,3.1218829296; 2024.563,3.1424617136;
            2025.062,3.1589247408; 2025.563,3.1671562544; 2026.064,3.1712720112;
            2026.565,3.2453556336; 2027.066,3.2700501744; 2027.565,3.3112077424;
            2028.066,3.2865132016; 2028.564,3.2659344176; 2029.066,3.1424617136;
            2029.564,3.154808984; 2030.061,3.2041980656; 2030.566,3.175387768;
            2031.065,3.1383459568; 2031.566,3.1218829296; 2032.063,3.1712720112;
            2032.565,3.0601465776; 2033.066,3.1465774704; 2033.565,3.1177671728;
            2034.067,3.113651416; 2034.567,3.1095356592; 2035.062,3.1383459568;
            2035.564,3.1630404976; 2036.065,3.1506932272; 2036.565,3.2083138224;
            2037.065,3.1671562544; 2037.566,3.1301144432; 2038.065,3.1095356592;
            2038.565,3.1712720112; 2039.064,3.0560308208; 2039.565,3.1218829296;
            2040.066,3.0971883888; 2040.565,3.1301144432; 2041.066,3.1671562544;
            2041.564,3.175387768; 2042.066,3.1383459568; 2042.565,3.1301144432;
            2043.065,3.113651416; 2043.565,3.1918507952; 2044.066,3.1877350384;
            2044.566,3.2124295792; 2045.065,3.1712720112; 2045.566,3.1671562544;
            2046.065,3.1918507952; 2046.561,3.1383459568; 2047.066,3.1630404976;
            2047.565,3.1424617136; 2048.065,3.1465774704; 2048.565,3.1218829296;
            2049.066,3.1259986864; 2049.566,3.1383459568; 2050.066,3.0766096048;
            2050.565,3.072493848; 2051.064,3.1054199024; 2051.562,3.1095356592;
            2052.062,3.0766096048; 2052.564,3.0642623344; 2053.066,3.0354520368;
            2053.566,3.0889568752; 2054.066,3.093072632; 2054.566,3.0807253616;
            2055.065,3.0642623344; 2055.562,3.0889568752; 2056.065,3.0766096048;
            2056.566,3.113651416; 2057.065,3.0807253616; 2057.562,3.0848411184;
            2058.065,3.0971883888; 2058.565,3.1054199024; 2059.066,3.0889568752;
            2059.564,3.0889568752; 2060.063,3.0395677936; 2060.563,3.03133628;
            2061.065,3.051915064; 2061.566,3.0477993072; 2062.065,3.1013041456;
            2062.565,3.1218829296; 2063.066,3.0848411184; 2063.563,3.113651416;
            2064.067,3.1383459568; 2064.565,3.1013041456; 2065.066,3.1589247408;
            2065.565,3.1795035248; 2066.065,3.2041980656; 2066.565,3.2412398768;
            2067.066,3.2288926064; 2067.564,3.2412398768; 2068.063,3.216545336;
            2068.565,3.1877350384; 2069.065,3.2083138224; 2069.562,3.1836192816;
            2070.062,3.154808984; 2070.575,3.1671562544; 2071.07,3.1630404976;
            2071.565,3.1836192816; 2072.064,3.1054199024; 2072.565,3.195966552;
            2073.065,3.154808984; 2073.563,3.1671562544; 2074.066,3.1671562544;
            2074.566,3.1836192816; 2075.064,3.216545336; 2075.565,3.1918507952;
            2076.063,3.1836192816; 2076.564,3.154808984; 2077.065,3.175387768;
            2077.566,3.1712720112; 2078.066,3.1671562544; 2078.562,3.1795035248;
            2079.065,3.1918507952; 2079.563,3.175387768; 2080.064,3.1671562544;
            2080.566,3.1301144432; 2081.063,3.1013041456; 2081.563,3.1054199024;
            2082.065,3.0560308208; 2082.564,3.0807253616; 2083.065,3.0971883888;
            2083.564,3.1506932272; 2084.066,3.1877350384; 2084.564,3.154808984;
            2085.066,3.1918507952; 2085.564,3.2124295792; 2086.065,3.175387768;
            2086.562,3.216545336; 2087.062,3.154808984; 2087.564,3.1095356592;
            2088.065,3.175387768; 2088.565,3.1836192816; 2089.065,3.2124295792;
            2089.565,3.2206610928; 2090.065,3.1671562544; 2090.564,3.2000823088;
            2091.063,3.175387768; 2091.565,3.2124295792; 2092.065,3.2412398768;
            2092.566,3.1630404976; 2093.065,3.2083138224; 2093.566,3.1342302;
            2094.064,3.1630404976; 2094.565,3.1424617136; 2095.065,3.1424617136;
            2095.568,3.1259986864; 2096.065,3.1054199024; 2096.565,3.1465774704;
            2097.067,3.1383459568; 2097.565,3.093072632; 2098.065,3.072493848;
            2098.565,3.1465774704; 2099.066,3.0971883888; 2099.565,3.1095356592;
            2100.066,3.1095356592; 2100.566,3.1013041456; 2101.065,3.0642623344;
            2101.565,3.0971883888; 2102.064,3.051915064; 2102.565,3.0066417392;
            2103.065,3.0148732528; 2103.564,3.0395677936; 2104.065,3.03133628;
            2104.567,3.0642623344; 2105.064,3.1054199024; 2105.565,3.0889568752;
            2106.065,3.051915064; 2106.565,3.0477993072; 2107.065,3.1342302;
            2107.566,3.072493848; 2108.068,3.0231047664; 2108.562,3.03133628;
            2109.066,3.0683780912; 2109.564,3.1301144432; 2110.062,3.113651416;
            2110.562,3.0848411184; 2111.063,3.0848411184; 2111.562,3.0683780912;
            2112.062,3.051915064; 2112.566,3.0889568752; 2113.065,3.0477993072;
            2113.564,3.03133628; 2114.066,3.072493848; 2114.562,3.0601465776;
            2115.062,3.0766096048; 2115.565,3.1013041456; 2116.066,3.0766096048;
            2116.563,3.1506932272; 2117.065,3.0560308208; 2117.563,3.1630404976;
            2118.063,3.1259986864; 2118.562,3.0766096048; 2119.063,3.1342302;
            2119.562,3.093072632; 2120.062,3.0848411184; 2120.563,3.0807253616;
            2121.063,3.1342302; 2121.562,3.1013041456; 2122.063,3.1342302;
            2122.563,3.154808984; 2123.063,3.1424617136; 2123.565,3.1465774704;
            2124.064,3.1671562544; 2124.564,3.1589247408; 2125.064,3.1506932272;
            2125.565,3.1383459568; 2126.064,3.1630404976; 2126.564,3.1630404976;
            2127.064,3.216545336; 2127.564,3.2041980656; 2128.065,3.2412398768;
            2128.563,3.2247768496; 2129.064,3.2288926064; 2129.566,3.2247768496;
            2130.065,3.2494713904; 2130.564,3.2906289584; 2131.066,3.278281688;
            2131.565,3.2453556336; 2132.066,3.23712412; 2132.566,3.195966552;
            2133.065,3.2083138224; 2133.563,3.2206610928; 2134.063,3.2206610928;
            2134.565,3.216545336; 2135.065,3.2206610928; 2135.563,3.2535871472;
            2136.065,3.2618186608; 2136.564,3.2083138224; 2137.066,3.2288926064;
            2137.563,3.1671562544; 2138.066,3.1506932272; 2138.565,3.195966552;
            2139.064,3.257702904; 2139.563,3.1795035248; 2140.064,3.2453556336;
            2140.564,3.2535871472; 2141.064,3.2535871472; 2141.563,3.2494713904;
            2142.064,3.2741659312; 2142.562,3.3029762288; 2143.065,3.2906289584;
            2143.566,3.2823974448; 2144.062,3.2906289584; 2144.565,3.2618186608;
            2145.063,3.2741659312; 2145.563,3.2823974448; 2146.066,3.2659344176;
            2146.562,3.23712412; 2147.062,3.216545336; 2147.565,3.195966552;
            2148.065,3.2535871472; 2148.563,3.2288926064; 2149.066,3.1877350384;
            2149.565,3.2330083632; 2150.066,3.1712720112; 2150.565,3.1712720112;
            2151.066,3.1465774704; 2151.566,3.1342302; 2152.063,3.1712720112;
            2152.565,3.1424617136; 2153.066,3.1836192816; 2153.566,3.1259986864;
            2154.065,3.1877350384; 2154.562,3.1465774704; 2155.062,3.1836192816;
            2155.563,3.2000823088; 2156.064,3.1301144432; 2156.564,3.1877350384;
            2157.065,3.093072632; 2157.565,3.0807253616; 2158.065,3.0971883888;
            2158.564,3.1712720112; 2159.064,3.1712720112; 2159.565,3.175387768;
            2160.065,3.2000823088; 2160.563,3.1712720112; 2161.064,3.1712720112;
            2161.566,3.1465774704; 2162.064,3.1712720112; 2162.564,3.2041980656;
            2163.064,3.2041980656; 2163.566,3.2000823088; 2164.065,3.113651416;
            2164.563,3.1795035248; 2165.064,3.1918507952; 2165.565,3.1218829296;
            2166.065,3.2041980656; 2166.565,3.1836192816; 2167.064,3.1712720112;
            2167.565,3.1712720112; 2168.065,3.1506932272; 2168.564,3.1383459568;
            2169.066,3.0889568752; 2169.564,3.1054199024; 2170.066,3.1013041456;
            2170.565,3.1218829296; 2171.066,3.1013041456; 2171.564,3.1383459568;
            2172.066,3.1301144432; 2172.565,3.2000823088; 2173.065,3.1918507952;
            2173.565,3.216545336; 2174.066,3.216545336; 2174.564,3.1671562544;
            2175.064,3.1795035248; 2175.564,3.2000823088; 2176.065,3.1836192816;
            2176.565,3.175387768; 2177.065,3.1836192816; 2177.565,3.1671562544;
            2178.064,3.1671562544; 2178.566,3.1506932272; 2179.064,3.1795035248;
            2179.563,3.1259986864; 2180.066,3.175387768; 2180.563,3.1383459568;
            2181.065,3.1383459568; 2181.565,3.1506932272; 2182.065,3.1301144432;
            2182.563,3.0971883888; 2183.066,3.0560308208; 2183.564,3.051915064;
            2184.064,3.0477993072; 2184.562,3.0848411184; 2185.066,3.1465774704;
            2185.565,3.0807253616; 2186.065,3.1342302; 2186.566,3.1259986864;
            2187.065,3.1712720112; 2187.565,3.154808984; 2188.065,3.154808984;
            2188.565,3.1342302; 2189.064,3.1259986864; 2189.565,3.1424617136;
            2190.065,3.1259986864; 2190.564,3.1630404976; 2191.064,3.154808984;
            2191.564,3.154808984; 2192.065,3.175387768; 2192.564,3.1795035248;
            2193.066,3.1795035248; 2193.564,3.154808984; 2194.065,3.2247768496;
            2194.565,3.1671562544; 2195.065,3.1836192816; 2195.566,3.1712720112;
            2196.064,3.175387768; 2196.565,3.175387768; 2197.064,3.1465774704;
            2197.562,3.1424617136; 2198.064,3.2412398768; 2198.564,3.2124295792;
            2199.065,3.1301144432; 2199.563,3.1383459568; 2200.065,3.1671562544;
            2200.565,3.1465774704; 2201.064,3.1712720112; 2201.565,3.0889568752;
            2202.065,3.1630404976; 2202.563,3.1671562544; 2203.064,3.1383459568;
            2203.565,3.1795035248; 2204.067,3.1218829296; 2204.564,3.1589247408;
            2205.065,3.1465774704; 2205.562,3.1383459568; 2206.065,3.0889568752;
            2206.565,3.1301144432; 2207.066,3.093072632; 2207.565,3.0848411184;
            2208.065,3.1054199024; 2208.564,3.1054199024; 2209.065,3.1424617136;
            2209.566,3.1383459568; 2210.065,3.1259986864; 2210.561,3.1218829296;
            2211.065,3.1383459568; 2211.563,3.154808984; 2212.065,3.1383459568;
            2212.565,3.1836192816; 2213.066,3.2083138224; 2213.564,3.1918507952;
            2214.065,3.2041980656; 2214.565,3.1589247408; 2215.065,3.1877350384;
            2215.561,3.2124295792; 2216.064,3.1877350384; 2216.563,3.2330083632;
            2217.064,3.1671562544; 2217.563,3.1836192816; 2218.066,3.1671562544;
            2218.566,3.1877350384; 2219.066,3.154808984; 2219.565,3.1877350384;
            2220.064,3.1589247408; 2220.561,3.1506932272; 2221.066,3.1836192816;
            2221.565,3.175387768; 2222.066,3.2083138224; 2222.565,3.1589247408;
            2223.066,3.1712720112; 2223.566,3.2000823088; 2224.065,3.1836192816;
            2224.566,3.2330083632; 2225.065,3.195966552; 2225.562,3.175387768;
            2226.065,3.2206610928; 2226.565,3.216545336; 2227.067,3.2535871472;
            2227.564,3.2412398768; 2228.065,3.2659344176; 2228.565,3.2206610928;
            2229.067,3.2659344176; 2229.565,3.23712412; 2230.066,3.298860472;
            2230.562,3.3112077424; 2231.065,3.2947447152; 2231.565,3.2741659312;
            2232.065,3.1630404976; 2232.565,3.1630404976; 2233.065,3.1424617136;
            2233.567,3.1465774704; 2234.067,3.113651416; 2234.566,3.1506932272;
            2235.066,3.1054199024; 2235.562,3.0971883888; 2236.065,3.093072632;
            2236.562,3.1383459568; 2237.065,3.0971883888; 2237.563,3.1259986864;
            2238.066,3.0560308208; 2238.565,3.0766096048; 2239.066,3.1095356592;
            2239.566,3.0683780912; 2240.066,3.093072632; 2240.563,3.0560308208;
            2241.065,3.1054199024; 2241.566,3.072493848; 2242.065,3.072493848;
            2242.566,3.0766096048; 2243.066,3.0889568752; 2243.565,3.1259986864;
            2244.064,3.0848411184; 2244.566,3.1013041456; 2245.065,3.1506932272;
            2245.562,3.1795035248; 2246.065,3.1506932272; 2246.566,3.0601465776;
            2247.066,3.0231047664; 2247.564,3.051915064; 2248.066,3.0889568752;
            2248.565,3.0642623344; 2249.067,3.1383459568; 2249.565,3.051915064;
            2250.066,3.0642623344; 2250.564,3.0436835504; 2251.064,3.0354520368;
            2251.565,3.0477993072; 2252.065,3.1013041456; 2252.565,3.0807253616;
            2253.066,3.1054199024; 2253.566,3.1671562544; 2254.065,3.1383459568;
            2254.567,3.113651416; 2255.066,3.154808984; 2255.563,3.1177671728;
            2256.066,3.154808984; 2256.564,3.1630404976; 2257.065,3.1342302;
            2257.565,3.1712720112; 2258.065,3.1712720112; 2258.566,3.2412398768;
            2259.067,3.1589247408; 2259.565,3.1918507952; 2260.064,3.23712412;
            2260.561,3.216545336; 2261.065,3.1918507952; 2261.565,3.2247768496;
            2262.065,3.195966552; 2262.564,3.2000823088; 2263.065,3.216545336;
            2263.566,3.1671562544; 2264.065,3.1877350384; 2264.566,3.1918507952;
            2265.064,3.1712720112; 2265.561,3.1342302; 2266.065,3.1589247408;
            2266.567,3.1589247408; 2267.066,3.1465774704; 2267.567,3.1177671728;
            2268.064,3.175387768; 2268.566,3.1630404976; 2269.066,3.1342302;
            2269.565,3.0848411184; 2270.065,3.1177671728; 2270.562,3.0766096048;
            2271.067,3.093072632; 2271.566,3.1383459568; 2272.066,3.1795035248;
            2272.565,3.1506932272; 2273.066,3.1465774704; 2273.565,3.2041980656;
            2274.065,3.1795035248; 2274.564,3.1589247408; 2275.065,3.1465774704;
            2275.565,3.154808984; 2276.067,3.1506932272; 2276.565,3.1795035248;
            2277.066,3.1877350384; 2277.566,3.1795035248; 2278.067,3.2124295792;
            2278.565,3.175387768; 2279.064,3.1918507952; 2279.564,3.2124295792;
            2280.064,3.1342302; 2280.566,3.2000823088; 2281.065,3.1301144432;
            2281.565,3.1795035248; 2282.066,3.154808984; 2282.566,3.1342302;
            2283.067,3.1013041456; 2283.564,3.195966552; 2284.067,3.2124295792;
            2284.565,3.1671562544; 2285.064,3.1259986864; 2285.565,3.1259986864;
            2286.066,3.1712720112; 2286.567,3.1712720112; 2287.065,3.1712720112;
            2287.565,3.1465774704; 2288.067,3.2000823088; 2288.566,3.1259986864;
            2289.065,3.1342302; 2289.566,3.1054199024; 2290.067,3.175387768;
            2290.566,3.1918507952; 2291.067,3.1630404976; 2291.566,3.2083138224;
            2292.066,3.1671562544; 2292.565,3.23712412; 2293.066,3.2288926064;
            2293.565,3.2041980656; 2294.066,3.2906289584; 2294.566,3.2453556336;
            2295.066,3.2618186608; 2295.567,3.2618186608; 2296.066,3.2823974448;
            2296.565,3.3441337968; 2297.066,3.2535871472; 2297.566,3.2330083632;
            2298.065,3.2330083632; 2298.565,3.2124295792; 2299.065,3.257702904;
            2299.566,3.278281688; 2300.064,3.257702904; 2300.566,3.23712412;
            2301.065,3.2247768496; 2301.566,3.2330083632; 2302.065,3.2535871472;
            2302.565,3.2618186608; 2303.066,3.2206610928; 2303.566,3.2865132016;
            2304.066,3.3029762288; 2304.565,3.23712412; 2305.066,3.2659344176;
            2305.564,3.298860472; 2306.065,3.2247768496; 2306.565,3.3235550128;
            2307.065,3.2494713904; 2307.563,3.3029762288; 2308.064,3.2865132016;
            2308.565,3.2947447152; 2309.064,3.2865132016; 2309.565,3.3153234992;
            2310.064,3.298860472; 2310.566,3.319439256; 2311.066,3.3359022832;
            2311.564,3.3112077424; 2312.067,3.3112077424; 2312.566,3.2823974448;
            2313.066,3.3112077424; 2313.566,3.2041980656; 2314.066,3.2124295792;
            2314.566,3.1836192816; 2315.065,3.1589247408; 2315.567,3.1795035248;
            2316.066,3.2330083632; 2316.566,3.2453556336; 2317.067,3.2330083632;
            2317.567,3.1836192816; 2318.063,3.175387768; 2318.567,3.2000823088;
            2319.065,3.1424617136; 2319.567,3.1424617136; 2320.066,3.1301144432;
            2320.565,3.1630404976; 2321.067,3.113651416; 2321.566,3.1301144432;
            2322.064,3.0971883888; 2322.566,3.1712720112; 2323.066,3.0971883888;
            2323.565,3.195966552; 2324.066,3.093072632; 2324.566,3.0766096048;
            2325.065,3.0848411184; 2325.565,3.1218829296; 2326.066,3.1589247408;
            2326.565,3.1301144432; 2327.065,3.1177671728; 2327.565,3.1712720112;
            2328.062,3.195966552; 2328.564,3.1712720112; 2329.066,3.2000823088;
            2329.565,3.1383459568; 2330.066,3.1342302; 2330.567,3.1301144432;
            2331.065,3.1795035248; 2331.565,3.1671562544; 2332.065,3.1630404976;
            2332.565,3.1630404976; 2333.066,3.1177671728; 2333.567,3.1383459568;
            2334.067,3.1342302; 2334.567,3.0642623344; 2335.066,3.1506932272;
            2335.565,3.1671562544; 2336.066,3.1795035248; 2336.565,3.1795035248;
            2337.065,3.154808984; 2337.565,3.2000823088; 2338.066,3.1918507952;
            2338.565,3.195966552; 2339.066,3.2000823088; 2339.566,3.175387768;
            2340.066,3.1712720112; 2340.567,3.216545336; 2341.066,3.195966552;
            2341.567,3.1918507952; 2342.065,3.1630404976; 2342.566,3.1836192816;
            2343.066,3.216545336; 2343.565,3.1836192816; 2344.063,3.23712412;
            2344.567,3.1918507952; 2345.064,3.2041980656; 2345.564,3.1301144432;
            2346.065,3.1630404976; 2346.567,3.1218829296; 2347.063,3.1877350384;
            2347.564,3.1259986864; 2348.064,3.1383459568; 2348.565,3.1589247408;
            2349.067,3.1095356592; 2349.564,3.1054199024; 2350.065,3.0642623344;
            2350.565,3.1259986864; 2351.065,3.0971883888; 2351.566,3.1013041456;
            2352.066,3.0889568752; 2352.564,3.1259986864; 2353.065,3.1095356592;
            2353.564,3.0848411184; 2354.065,3.072493848; 2354.564,3.1424617136;
            2355.063,3.1424617136; 2355.563,3.1013041456; 2356.066,3.1218829296;
            2356.565,3.1301144432; 2357.063,3.1424617136; 2357.565,3.1259986864;
            2358.061,3.1301144432; 2358.566,3.1054199024; 2359.066,3.1095356592;
            2359.566,3.1218829296; 2360.064,3.1259986864; 2360.565,3.1465774704;
            2361.066,3.1342302; 2361.567,3.1424617136; 2362.065,3.1918507952;
            2362.565,3.2330083632; 2363.066,3.298860472; 2363.566,3.2947447152;
            2364.066,3.2823974448; 2364.567,3.2412398768; 2365.066,3.1918507952;
            2365.565,3.195966552; 2366.099,3.1424617136; 2366.567,3.1712720112;
            2367.065,3.1918507952; 2367.563,3.1013041456; 2368.066,3.1301144432;
            2368.565,3.1177671728; 2369.064,3.113651416; 2369.566,3.2247768496;
            2370.064,3.1836192816; 2370.566,3.195966552; 2371.067,3.2000823088;
            2371.565,3.1342302; 2372.066,3.154808984; 2372.566,3.1671562544;
            2373.066,3.2041980656; 2373.566,3.113651416; 2374.067,3.0889568752;
            2374.566,3.0766096048; 2375.065,3.0683780912; 2375.565,3.1054199024;
            2376.067,3.1630404976; 2376.565,3.216545336; 2377.066,3.1918507952;
            2377.566,3.1589247408; 2378.066,3.1918507952; 2378.565,3.216545336;
            2379.065,3.2124295792; 2379.566,3.2494713904; 2380.065,3.175387768;
            2380.566,3.2083138224; 2381.065,3.2494713904; 2381.566,3.2330083632;
            2382.066,3.154808984; 2382.565,3.175387768; 2383.065,3.2083138224;
            2383.563,3.175387768; 2384.063,3.1013041456; 2384.566,3.1218829296;
            2385.067,3.1301144432; 2385.566,3.0807253616; 2386.065,3.1506932272;
            2386.565,3.113651416; 2387.067,3.1013041456; 2387.566,3.0971883888;
            2388.065,3.113651416; 2388.565,3.113651416; 2389.066,3.1218829296;
            2389.566,3.113651416; 2390.067,3.113651416; 2390.565,3.1342302;
            2391.066,3.1301144432; 2391.564,3.1671562544; 2392.065,3.1259986864;
            2392.567,3.0889568752; 2393.065,3.0807253616; 2393.566,3.0889568752;
            2394.065,3.0354520368; 2394.565,3.113651416; 2395.066,3.093072632;
            2395.564,3.1095356592; 2396.064,3.1177671728; 2396.565,3.1095356592;
            2397.065,3.093072632; 2397.563,3.1671562544; 2398.066,3.2000823088;
            2398.566,3.1795035248; 2399.067,3.2453556336; 2399.566,3.2288926064;
            2400.066,3.2659344176; 2400.564,3.2247768496; 2401.066,3.2535871472;
            2401.567,3.1630404976; 2402.065,3.2494713904; 2402.567,3.1795035248;
            2403.064,3.2041980656; 2403.565,3.1918507952; 2404.064,3.195966552;
            2404.565,3.1836192816; 2405.065,3.2041980656; 2405.566,3.1506932272;
            2406.066,3.1589247408; 2406.566,3.1589247408; 2407.064,3.154808984;
            2407.566,3.1630404976; 2408.066,3.175387768; 2408.563,3.1671562544;
            2409.066,3.1671562544; 2409.566,3.1671562544; 2410.066,3.1054199024;
            2410.566,3.1877350384; 2411.065,3.1795035248; 2411.562,3.1465774704;
            2412.066,3.1671562544; 2412.565,3.1712720112; 2413.066,3.1383459568;
            2413.565,3.1630404976; 2414.065,3.175387768; 2414.567,3.1301144432;
            2415.065,3.1630404976; 2415.566,3.1589247408; 2416.067,3.1836192816;
            2416.567,3.1218829296; 2417.066,3.1589247408; 2417.565,3.0766096048;
            2418.065,3.0971883888; 2418.563,3.0766096048; 2419.066,3.1877350384;
            2419.563,3.1671562544; 2420.065,3.2041980656; 2420.564,3.2000823088;
            2421.066,3.195966552; 2421.567,3.1671562544; 2422.066,3.175387768;
            2422.567,3.2041980656; 2423.065,3.216545336; 2423.565,3.2247768496;
            2424.063,3.2041980656; 2424.565,3.2330083632; 2425.067,3.1918507952;
            2425.563,3.2453556336; 2426.064,3.2124295792; 2426.567,3.195966552;
            2427.066,3.1465774704; 2427.565,3.1836192816; 2428.066,3.1465774704;
            2428.566,3.1506932272; 2429.066,3.154808984; 2429.566,3.1589247408;
            2430.066,3.1506932272; 2430.565,3.1671562544; 2431.066,3.1383459568;
            2431.565,3.1424617136; 2432.066,3.1177671728; 2432.567,3.072493848;
            2433.066,3.1095356592; 2433.565,3.0807253616; 2434.067,3.113651416;
            2434.565,3.0807253616; 2435.065,3.072493848; 2435.562,3.0807253616;
            2436.067,3.0848411184; 2436.564,3.1013041456; 2437.066,3.072493848;
            2437.567,3.1259986864; 2438.066,3.1177671728; 2438.567,3.1465774704;
            2439.066,3.093072632; 2439.567,3.1259986864; 2440.066,3.1054199024;
            2440.567,3.1177671728; 2441.067,3.1177671728; 2441.563,3.1671562544;
            2442.062,3.1630404976; 2442.563,3.1630404976; 2443.067,3.1506932272;
            2443.565,3.1342302; 2444.066,3.1218829296; 2444.562,3.113651416;
            2445.065,3.1342302; 2445.567,3.1095356592; 2446.065,3.1671562544;
            2446.566,3.1095356592; 2447.066,3.1301144432; 2447.565,3.1342302;
            2448.066,3.154808984; 2448.565,3.1506932272; 2449.064,3.1177671728;
            2449.565,3.1589247408; 2450.066,3.1630404976; 2450.565,3.1465774704;
            2451.065,3.154808984; 2451.566,3.2000823088; 2452.067,3.1630404976;
            2452.564,3.175387768; 2453.066,3.2288926064; 2453.566,3.2741659312;
            2454.065,3.2741659312; 2454.565,3.2906289584; 2455.066,3.2618186608;
            2455.566,3.2535871472; 2456.064,3.1671562544; 2456.565,3.2000823088;
            2457.065,3.1712720112; 2457.565,3.1301144432; 2458.066,3.1836192816;
            2458.566,3.1218829296; 2459.067,3.1424617136; 2459.566,3.1054199024;
            2460.065,3.0971883888; 2460.565,3.175387768; 2461.066,3.1836192816;
            2461.566,3.1465774704; 2462.066,3.1671562544; 2462.565,3.175387768;
            2463.065,3.1712720112; 2463.567,3.1630404976; 2464.065,3.1630404976;
            2464.567,3.1918507952; 2465.065,3.1795035248; 2465.561,3.1177671728;
            2466.066,3.1795035248; 2466.564,3.1177671728; 2467.066,3.154808984;
            2467.566,3.1465774704; 2468.065,3.0889568752; 2468.566,3.1095356592;
            2469.065,3.1424617136; 2469.565,3.1671562544; 2470.066,3.1589247408;
            2470.565,3.1795035248; 2471.064,3.1836192816; 2471.566,3.2000823088;
            2472.062,3.1424617136; 2472.566,3.1259986864; 2473.066,3.175387768;
            2473.566,3.216545336; 2474.067,3.2247768496; 2474.566,3.2000823088;
            2475.065,3.175387768; 2475.565,3.2083138224; 2476.063,3.195966552;
            2476.566,3.2412398768; 2477.066,3.1795035248; 2477.565,3.1671562544;
            2478.067,3.1877350384; 2478.565,3.1795035248; 2479.067,3.1589247408;
            2479.566,3.0848411184; 2480.065,3.1259986864; 2480.566,3.1630404976;
            2481.066,3.1054199024; 2481.564,3.1054199024; 2482.065,3.1259986864;
            2482.567,3.1342302; 2483.066,3.1259986864; 2483.565,3.0971883888;
            2484.067,3.0807253616; 2484.564,3.1054199024; 2485.066,3.0601465776;
            2485.566,3.0683780912; 2486.066,3.0560308208; 2486.565,3.1095356592;
            2487.065,3.1054199024; 2487.564,3.0683780912; 2488.065,3.1095356592;
            2488.562,3.1013041456; 2489.065,3.113651416; 2489.565,3.1259986864;
            2490.066,3.1301144432; 2490.565,3.1342302; 2491.064,3.1589247408;
            2491.566,3.1383459568; 2492.065,3.154808984; 2492.565,3.1506932272;
            2493.064,3.1671562544; 2493.566,3.1301144432; 2494.065,3.113651416;
            2494.562,3.0848411184; 2495.063,3.1095356592; 2495.564,3.1383459568;
            2496.063,3.1259986864; 2496.566,3.154808984; 2497.067,3.1301144432;
            2497.565,3.1424617136; 2498.063,3.1177671728; 2498.566,3.1259986864;
            2499.063,3.1465774704; 2499.565,3.195966552; 2500.065,3.175387768;
            2500.567,3.1836192816; 2501.063,3.1177671728; 2501.567,3.154808984;
            2502.065,3.1506932272; 2502.566,3.1589247408; 2503.067,3.1177671728;
            2503.565,3.1795035248; 2504.066,3.1424617136; 2504.565,3.1424617136;
            2505.066,3.1506932272; 2505.566,3.1054199024; 2506.064,3.1712720112;
            2506.565,3.1630404976; 2507.066,3.1836192816; 2507.566,3.1836192816;
            2508.067,3.1918507952; 2508.565,3.2124295792; 2509.063,3.2083138224;
            2509.565,3.2330083632; 2510.065,3.2041980656; 2510.567,3.2823974448;
            2511.064,3.2494713904; 2511.565,3.2700501744; 2512.067,3.2700501744;
            2512.566,3.2412398768; 2513.066,3.2618186608; 2513.566,3.3647125808;
            2514.066,3.3359022832; 2514.566,3.3070919856; 2515.066,3.319439256;
            2515.565,3.3029762288; 2516.062,3.3029762288; 2516.563,3.3070919856;
            2517.064,3.257702904; 2517.567,3.2453556336; 2518.067,3.278281688;
            2518.565,3.2247768496; 2519.067,3.2412398768; 2519.566,3.2124295792;
            2520.067,3.2083138224; 2520.565,3.2124295792; 2521.063,3.2041980656;
            2521.564,3.2083138224; 2522.066,3.2412398768; 2522.565,3.2453556336;
            2523.066,3.1630404976; 2523.563,3.216545336; 2524.065,3.1877350384;
            2524.564,3.2206610928; 2525.065,3.1506932272; 2525.567,3.1424617136;
            2526.064,3.1671562544; 2526.566,3.1095356592; 2527.066,3.1424617136;
            2527.566,3.1795035248; 2528.066,3.1342302; 2528.566,3.1465774704;
            2529.066,3.1506932272; 2529.567,3.195966552; 2530.066,3.154808984;
            2530.566,3.1465774704; 2531.066,3.175387768; 2531.564,3.1342302;
            2532.066,3.1589247408; 2532.568,3.175387768; 2533.067,3.175387768;
            2533.566,3.2000823088; 2534.064,3.1506932272; 2534.566,3.2000823088;
            2535.065,3.195966552; 2535.567,3.1918507952; 2536.066,3.1918507952;
            2536.566,3.2041980656; 2537.066,3.1836192816; 2537.566,3.2206610928;
            2538.067,3.2041980656; 2538.566,3.1712720112; 2539.067,3.1589247408;
            2539.567,3.1918507952; 2540.067,3.2247768496; 2540.566,3.1795035248;
            2541.067,3.2000823088; 2541.566,3.1671562544; 2542.067,3.195966552;
            2542.566,3.1795035248; 2543.065,3.1712720112; 2543.566,3.1465774704;
            2544.066,3.1671562544; 2544.568,3.1177671728; 2545.066,3.1506932272;
            2545.566,3.1712720112; 2546.067,3.1465774704; 2546.567,3.1465774704;
            2547.065,3.175387768; 2547.567,3.0971883888; 2548.067,3.1918507952;
            2548.566,3.1259986864; 2549.065,3.1259986864; 2549.565,3.0889568752;
            2550.066,3.1465774704; 2550.565,3.1013041456; 2551.066,3.1218829296;
            2551.566,3.113651416; 2552.067,3.1712720112; 2552.565,3.113651416;
            2553.065,3.154808984; 2553.566,3.1465774704; 2554.072,3.1465774704],
        tableName="botValve",
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents)
        annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
      Modelica.Blocks.Sources.CombiTimeTable TopValve(
        tableOnFile=false,
        table=[0,9.1350036144; 0.57,9.1103090736; 1.061,9.1391193712; 1.56,
            9.0979618032; 2.063,9.1926242096; 2.562,9.1596981552; 3.062,
            9.122656344; 3.562,9.163813912; 4.062,9.1185405872; 4.562,
            9.1350036144; 5.059,9.0897302896; 5.562,9.0362254512; 6.062,
            9.0238781808; 6.563,8.9539103152; 7.061,8.99918364; 7.563,
            8.978604856; 8.061,9.0074151536; 8.561,8.99918364; 9.061,
            9.0279939376; 9.562,8.9950678832; 10.061,9.0321096944; 10.562,
            9.0074151536; 11.061,9.081498776; 11.563,9.0732672624; 12.06,
            9.1185405872; 12.561,9.0938460464; 13.061,9.0156466672; 13.562,
            9.0444569648; 14.059,9.0568042352; 14.561,9.081498776; 15.061,
            9.0279939376; 15.562,9.0321096944; 16.06,9.0691515056; 16.559,
            9.0938460464; 17.062,9.0773830192; 17.562,9.1267721008; 18.062,
            9.0856145328; 18.56,9.10207756; 19.063,9.1185405872; 19.562,
            9.0979618032; 20.062,9.1720454256; 20.561,9.1761611824; 21.062,
            9.1885084528; 21.561,9.1473508848; 22.061,9.0485727216; 22.562,
            9.0485727216; 23.061,9.0732672624; 23.561,9.0691515056; 24.062,
            9.0238781808; 24.561,9.040341208; 25.063,9.0115309104; 25.561,
            9.081498776; 26.062,9.1144248304; 26.561,9.1267721008; 27.062,
            9.1802769392; 27.562,9.1391193712; 28.061,9.20497148; 28.562,
            9.1308878576; 29.062,9.10207756; 29.563,9.184392696; 30.062,
            9.163813912; 30.562,9.1555823984; 31.062,9.122656344; 31.563,
            9.184392696; 32.061,9.20497148; 32.559,9.1761611824; 33.063,
            9.1391193712; 33.56,9.122656344; 34.06,9.0691515056; 34.561,
            9.0938460464; 35.061,9.1144248304; 35.56,9.1267721008; 36.062,
            9.1391193712; 36.562,9.1061933168; 37.061,9.0856145328; 37.562,
            9.10207756; 38.061,9.0691515056; 38.56,9.0938460464; 39.06,
            9.0938460464; 39.563,9.0238781808; 40.061,9.0691515056; 40.562,
            9.1350036144; 41.061,9.0856145328; 41.561,9.040341208; 42.063,
            9.0526884784; 42.56,8.99918364; 43.061,9.0526884784; 43.558,
            9.0732672624; 44.061,9.1391193712; 44.562,8.9909521264; 45.062,
            9.019762424; 45.56,9.0238781808; 46.064,9.0156466672; 46.562,
            9.0485727216; 47.06,9.0773830192; 47.56,9.0732672624; 48.061,
            9.1267721008; 48.561,9.1885084528; 49.061,9.1926242096; 49.561,
            9.1720454256; 50.061,9.1391193712; 50.561,9.1350036144; 51.062,
            9.143235128; 51.56,9.1473508848; 52.061,9.1185405872; 52.561,
            9.1185405872; 53.062,9.1185405872; 53.562,9.0732672624; 54.058,
            9.1144248304; 54.56,9.0938460464; 55.06,9.1514666416; 55.561,
            9.122656344; 56.062,9.1308878576; 56.562,9.1185405872; 57.061,
            9.184392696; 57.561,9.2337817776; 58.061,9.20497148; 58.559,
            9.225550264; 59.058,9.2584763184; 59.558,9.266707832; 60.058,
            9.2132029936; 60.559,9.1267721008; 61.06,9.1144248304; 61.56,
            9.0856145328; 62.061,9.0773830192; 62.56,8.99918364; 63.058,
            9.0156466672; 63.56,9.0032993968; 64.059,9.019762424; 64.559,
            9.0321096944; 65.063,9.0526884784; 65.561,9.0444569648; 66.062,
            9.0773830192; 66.561,9.040341208; 67.061,9.0526884784; 67.562,
            9.0938460464; 68.062,9.081498776; 68.561,9.1103090736; 69.062,
            9.1308878576; 69.562,9.1514666416; 70.061,9.1391193712; 70.561,
            9.1555823984; 71.061,9.0938460464; 71.561,9.1308878576; 72.061,
            9.1061933168; 72.558,9.1185405872; 73.062,9.1473508848; 73.562,
            9.1720454256; 74.062,9.1967399664; 74.561,9.2008557232; 75.062,
            9.1185405872; 75.561,9.1679296688; 76.061,9.1185405872; 76.562,
            9.1555823984; 77.062,9.1350036144; 77.562,9.1391193712; 78.062,
            9.1308878576; 78.563,9.143235128; 79.061,9.1473508848; 79.56,
            9.1185405872; 80.061,9.1267721008; 80.561,9.0279939376; 81.062,
            9.0321096944; 81.561,9.0444569648; 82.061,9.1761611824; 82.561,
            9.1802769392; 83.061,9.1720454256; 83.562,9.1761611824; 84.06,
            9.2132029936; 84.56,9.1596981552; 85.063,9.1596981552; 85.562,
            9.1473508848; 86.062,9.1679296688; 86.561,9.1926242096; 87.062,
            9.2214345072; 87.561,9.2625920752; 88.062,9.2296660208; 88.561,
            9.2132029936; 89.061,9.20497148; 89.562,9.2502448048; 90.062,
            9.2337817776; 90.562,9.225550264; 91.061,9.1761611824; 91.561,
            9.2008557232; 92.061,9.184392696; 92.561,9.1802769392; 93.061,
            9.1761611824; 93.56,9.1761611824; 94.061,9.122656344; 94.561,
            9.1185405872; 95.061,9.1555823984; 95.561,9.1103090736; 96.071,
            9.0238781808; 96.561,9.0279939376; 97.063,9.0856145328; 97.562,
            9.1350036144; 98.062,9.1308878576; 98.561,9.0773830192; 99.062,
            9.1061933168; 99.562,9.0732672624; 100.063,9.143235128; 100.563,
            9.0732672624; 101.061,9.0856145328; 101.562,9.0979618032; 102.062,
            9.1185405872; 102.561,9.0773830192; 103.061,9.0568042352; 103.563,
            9.1103090736; 104.063,9.0568042352; 104.562,9.0732672624; 105.091,
            9.1144248304; 105.559,9.1267721008; 106.061,9.0979618032; 106.56,
            9.060919992; 107.061,9.060919992; 107.56,8.9909521264; 108.062,
            9.0568042352; 108.561,9.0444569648; 109.061,9.0526884784; 109.561,
            9.0979618032; 110.062,9.0732672624; 110.561,9.060919992; 111.061,
            9.10207756; 111.561,9.122656344; 112.06,9.0856145328; 112.562,
            9.1061933168; 113.059,9.1350036144; 113.562,9.060919992; 114.062,
            9.0773830192; 114.561,9.1061933168; 115.063,9.1761611824; 115.562,
            9.1720454256; 116.063,9.1679296688; 116.561,9.2173187504; 117.063,
            9.1720454256; 117.562,9.184392696; 118.061,9.1885084528; 118.561,
            9.1802769392; 119.062,9.184392696; 119.563,9.163813912; 120.062,
            9.1267721008; 120.563,9.1103090736; 121.061,9.1473508848; 121.562,
            9.2090872368; 122.061,9.1802769392; 122.562,9.163813912; 123.063,
            9.184392696; 123.562,9.1555823984; 124.063,9.143235128; 124.563,
            9.1350036144; 125.062,9.143235128; 125.561,9.1555823984; 126.062,
            9.1391193712; 126.56,9.184392696; 127.061,9.1885084528; 127.564,
            9.1761611824; 128.063,9.1267721008; 128.563,9.0444569648; 129.075,
            9.0650357488; 129.562,9.0279939376; 130.061,8.9909521264; 130.56,
            9.0568042352; 131.063,9.1103090736; 131.561,9.1350036144; 132.06,
            9.1061933168; 132.561,9.1596981552; 133.06,9.1473508848; 133.56,
            9.143235128; 134.062,9.1596981552; 134.561,9.163813912; 135.06,
            9.1555823984; 135.562,9.1391193712; 136.062,9.1555823984; 136.559,
            9.1802769392; 137.059,9.1514666416; 137.559,9.2008557232; 138.07,
            9.163813912; 138.56,9.122656344; 139.062,9.1308878576; 139.558,
            9.1103090736; 140.061,9.081498776; 140.561,9.1144248304; 141.06,
            9.1061933168; 141.562,9.10207756; 142.062,9.081498776; 142.562,
            9.0691515056; 143.061,9.0568042352; 143.562,8.9868363696; 144.062,
            9.0279939376; 144.562,9.0362254512; 145.06,9.0691515056; 145.562,
            9.0897302896; 146.062,9.081498776; 146.558,9.0979618032; 147.064,
            9.0650357488; 147.562,9.081498776; 148.06,9.081498776; 148.562,
            9.0568042352; 149.062,9.122656344; 149.562,9.0732672624; 150.062,
            9.1267721008; 150.562,9.0897302896; 151.06,9.0444569648; 151.563,
            9.0032993968; 152.062,9.0279939376; 152.561,9.0156466672; 153.064,
            9.040341208; 153.562,9.060919992; 154.062,9.0526884784; 154.562,
            9.1267721008; 155.059,9.1473508848; 155.562,9.1885084528; 156.061,
            9.2625920752; 156.56,9.246129048; 157.063,9.3037496432; 157.563,
            9.246129048; 158.061,9.2378975344; 158.563,9.2502448048; 159.061,
            9.225550264; 159.56,9.20497148; 160.062,9.1885084528; 160.562,
            9.1926242096; 161.062,9.1267721008; 161.558,9.1679296688; 162.062,
            9.10207756; 162.567,9.1144248304; 163.061,9.1802769392; 163.561,
            9.1350036144; 164.061,9.1267721008; 164.559,9.1514666416; 165.06,
            9.0979618032; 165.558,9.143235128; 166.059,9.1391193712; 166.559,
            9.1761611824; 167.059,9.060919992; 167.559,9.1391193712; 168.062,
            9.1185405872; 168.558,9.1103090736; 169.06,9.1185405872; 169.562,
            9.143235128; 170.062,9.1391193712; 170.561,9.143235128; 171.065,
            9.1473508848; 171.559,9.1514666416; 172.062,9.1761611824; 172.56,
            9.1802769392; 173.059,9.1967399664; 173.56,9.1926242096; 174.06,
            9.1802769392; 174.56,9.1514666416; 175.059,9.1885084528; 175.559,
            9.1679296688; 176.062,9.1514666416; 176.56,9.1061933168; 177.061,
            9.1308878576; 177.561,9.0979618032; 178.06,9.060919992; 178.558,
            9.081498776; 179.06,9.1350036144; 179.559,9.0979618032; 180.06,
            9.081498776; 180.561,9.081498776; 181.061,9.081498776; 181.559,
            9.1061933168; 182.061,9.1103090736; 182.56,9.1144248304; 183.062,
            9.1391193712; 183.562,9.143235128; 184.06,9.10207756; 184.563,
            9.1308878576; 185.061,9.143235128; 185.562,9.1308878576; 186.059,
            9.1103090736; 186.559,9.1555823984; 187.062,9.1308878576; 187.562,
            9.1514666416; 188.061,9.1967399664; 188.559,9.1761611824; 189.061,
            9.2420132912; 189.561,9.1885084528; 190.062,9.1885084528; 190.561,
            9.163813912; 191.062,9.1885084528; 191.558,9.1926242096; 192.06,
            9.0897302896; 192.559,9.0650357488; 193.062,9.1350036144; 193.561,
            9.0691515056; 194.062,8.9909521264; 194.562,9.0568042352; 195.062,
            9.0485727216; 195.562,9.060919992; 196.058,9.0691515056; 196.558,
            9.10207756; 197.061,9.0938460464; 197.561,9.0732672624; 198.062,
            9.122656344; 198.563,9.0568042352; 199.061,9.10207756; 199.561,
            9.0938460464; 200.062,9.0732672624; 200.559,9.1473508848; 201.062,
            9.0897302896; 201.559,9.163813912; 202.062,9.143235128; 202.561,
            9.1596981552; 203.062,9.143235128; 203.563,9.143235128; 204.061,
            9.1144248304; 204.563,9.1926242096; 205.062,9.1308878576; 205.562,
            9.1473508848; 206.061,9.1350036144; 206.56,9.1144248304; 207.06,
            9.143235128; 207.562,9.1391193712; 208.062,9.0979618032; 208.559,
            9.0938460464; 209.062,9.0773830192; 209.562,9.0732672624; 210.061,
            9.0897302896; 210.562,9.1103090736; 211.063,9.143235128; 211.562,
            9.10207756; 212.062,9.1885084528; 212.562,9.122656344; 213.062,
            9.1514666416; 213.561,9.143235128; 214.061,9.1473508848; 214.559,
            9.1926242096; 215.062,9.2090872368; 215.562,9.2008557232; 216.061,
            9.1967399664; 216.563,9.2584763184; 217.059,9.2543605616; 217.562,
            9.2543605616; 218.062,9.2378975344; 218.563,9.1761611824; 219.063,
            9.163813912; 219.56,9.1967399664; 220.062,9.2090872368; 220.562,
            9.20497148; 221.061,9.225550264; 221.563,9.2296660208; 222.061,
            9.2132029936; 222.562,9.2090872368; 223.061,9.1885084528; 223.562,
            9.2008557232; 224.061,9.2173187504; 224.56,9.2173187504; 225.063,
            9.2173187504; 225.562,9.1596981552; 226.062,9.143235128; 226.56,
            9.122656344; 227.061,9.1679296688; 227.561,9.163813912; 228.062,
            9.2337817776; 228.561,9.246129048; 229.059,9.2214345072; 229.561,
            9.246129048; 230.062,9.246129048; 230.561,9.246129048; 231.062,
            9.2132029936; 231.56,9.1967399664; 232.062,9.1802769392; 232.563,
            9.163813912; 233.06,9.1802769392; 233.562,9.184392696; 234.06,
            9.1926242096; 234.56,9.1802769392; 235.06,9.184392696; 235.561,
            9.1761611824; 236.062,9.1679296688; 236.561,9.184392696; 237.062,
            9.1555823984; 237.561,9.1596981552; 238.061,9.1885084528; 238.562,
            9.1473508848; 239.062,9.163813912; 239.559,9.1267721008; 240.061,
            9.1596981552; 240.559,9.1761611824; 241.061,9.184392696; 241.559,
            9.1761611824; 242.061,9.1967399664; 242.558,9.2296660208; 243.062,
            9.2132029936; 243.562,9.2214345072; 244.061,9.20497148; 244.561,
            9.2090872368; 245.061,9.246129048; 245.559,9.2337817776; 246.061,
            9.2543605616; 246.56,9.2914023728; 247.062,9.2502448048; 247.561,
            9.266707832; 248.059,9.2337817776; 248.561,9.2584763184; 249.06,
            9.2378975344; 249.562,9.1926242096; 250.063,9.2337817776; 250.561,
            9.1885084528; 251.06,9.1926242096; 251.561,9.2132029936; 252.06,
            9.1720454256; 252.562,9.163813912; 253.06,9.1679296688; 253.561,
            9.1308878576; 254.062,9.1473508848; 254.562,9.1308878576; 255.058,
            9.1679296688; 255.562,9.20908723680001; 256.063,9.1679296688;
            256.562,9.2337817776; 257.061,9.2378975344; 257.563,9.2296660208;
            258.059,9.2296660208; 258.567,9.2173187504; 259.062,9.2337817776;
            259.562,9.2296660208; 260.063,9.2584763184; 260.558,9.2337817776;
            261.058,9.2749393456; 261.559,9.246129048; 262.059,9.2420132912;
            262.56,9.2502448048; 263.059,9.266707832; 263.559,9.2955181296;
            264.062,9.2378975344; 264.559,9.2214345072; 265.059,9.2296660208;
            265.562,9.246129048; 266.062,9.1473508848; 266.562,9.1967399664;
            267.06,9.1350036144; 267.563,9.1885084528; 268.062,9.1061933168;
            268.561,9.1514666416; 269.061,9.1555823984; 269.561,9.1555823984;
            270.062,9.1473508848; 270.561,9.163813912; 271.062,9.1391193712;
            271.562,9.1185405872; 272.062,9.122656344; 272.562,9.143235128;
            273.062,9.1103090736; 273.562,9.1802769392; 274.063,9.1596981552;
            274.562,9.1514666416; 275.062,9.1391193712; 275.563,9.0979618032;
            276.064,9.1596981552; 276.559,9.1514666416; 277.062,9.1967399664;
            277.561,9.1926242096; 278.061,9.1802769392; 278.563,9.184392696;
            279.062,9.1720454256; 279.561,9.163813912; 280.062,9.1720454256;
            280.562,9.1720454256; 281.061,9.1596981552; 281.559,9.1679296688;
            282.062,9.1802769392; 282.561,9.1555823984; 283.062,9.1679296688;
            283.563,9.1885084528; 284.059,9.1514666416; 284.562,9.1761611824;
            285.061,9.20497148; 285.561,9.2420132912; 286.062,9.225550264;
            286.56,9.2584763184; 287.061,9.2790551024; 287.559,9.2214345072;
            288.062,9.2173187504; 288.562,9.184392696; 289.062,9.2543605616;
            289.564,9.2625920752; 290.062,9.225550264; 290.563,9.1926242096;
            291.059,9.122656344; 291.559,9.122656344; 292.062,9.1761611824;
            292.563,9.266707832; 293.062,9.2790551024; 293.563,9.1596981552;
            294.062,9.1720454256; 294.559,9.122656344; 295.063,9.1308878576;
            295.561,9.1267721008; 296.061,9.1596981552; 296.561,9.20497148;
            297.061,9.1596981552; 297.563,9.2132029936; 298.061,9.2008557232;
            298.561,9.2214345072; 299.061,9.2008557232; 299.559,9.225550264;
            300.063,9.1885084528; 300.561,9.2008557232; 301.061,9.2008557232;
            301.564,9.225550264; 302.061,9.1967399664; 302.562,9.2090872368;
            303.063,9.2502448048; 303.562,9.2090872368; 304.062,9.2296660208;
            304.562,9.225550264; 305.062,9.2173187504; 305.561,9.2378975344;
            306.063,9.1761611824; 306.563,9.2337817776; 307.064,9.2214345072;
            307.561,9.2008557232; 308.061,9.246129048; 308.564,9.2214345072;
            309.063,9.2378975344; 309.563,9.246129048; 310.061,9.2584763184;
            310.561,9.2296660208; 311.062,9.225550264; 311.562,9.2337817776;
            312.062,9.225550264; 312.561,9.2296660208; 313.06,9.2173187504;
            313.562,9.2214345072; 314.062,9.2008557232; 314.562,9.2214345072;
            315.062,9.20497148; 315.561,9.1802769392; 316.062,9.266707832;
            316.562,9.2337817776; 317.062,9.2543605616; 317.56,9.2502448048;
            318.063,9.2296660208; 318.561,9.2502448048; 319.064,9.1967399664;
            319.561,9.2090872368; 320.063,9.2420132912; 320.561,9.2214345072;
            321.062,9.246129048; 321.563,9.2090872368; 322.062,9.1926242096;
            322.56,9.225550264; 323.062,9.2090872368; 323.563,9.225550264;
            324.064,9.2584763184; 324.562,9.2420132912; 325.063,9.3037496432;
            325.561,9.2625920752; 326.064,9.2625920752; 326.563,9.2214345072;
            327.062,9.2420132912; 327.563,9.2708235888; 328.063,9.2955181296;
            328.561,9.287286616; 329.061,9.2914023728; 329.561,9.2584763184;
            330.061,9.2214345072; 330.563,9.225550264; 331.061,9.1802769392;
            331.563,9.2008557232; 332.064,9.2749393456; 332.562,9.2749393456;
            333.062,9.2543605616; 333.561,9.3037496432; 334.062,9.2625920752;
            334.561,9.3119811568; 335.062,9.2914023728; 335.562,9.3243284272;
            336.063,9.2996338864; 336.562,9.3325599408; 337.062,9.390180536;
            337.562,9.41075932; 338.062,9.3942962928; 338.561,9.41075932;
            339.062,9.3531387248; 339.563,9.3243284272; 340.063,9.2955181296;
            340.563,9.2831708592; 341.063,9.2543605616; 341.558,9.2337817776;
            342.06,9.2378975344; 342.561,9.2296660208; 343.061,9.2502448048;
            343.563,9.246129048; 344.06,9.2296660208; 344.564,9.2090872368;
            345.063,9.2831708592; 345.563,9.266707832; 346.059,9.3160969136;
            346.562,9.287286616; 347.062,9.328444184; 347.562,9.3243284272;
            348.062,9.3119811568; 348.563,9.3243284272; 349.062,9.3572544816;
            349.563,9.3449072112; 350.063,9.3737175088; 350.562,9.3613702384;
            351.062,9.3078654; 351.561,9.3037496432; 352.062,9.2790551024;
            352.561,9.2378975344; 353.061,9.2337817776; 353.562,9.2584763184;
            354.062,9.2955181296; 354.562,9.3202126704; 355.062,9.3037496432;
            355.563,9.328444184; 356.062,9.3202126704; 356.56,9.3449072112;
            357.062,9.3654859952; 357.561,9.3984120496; 358.062,9.369601752;
            358.561,9.287286616; 359.064,9.2749393456; 359.561,9.3613702384;
            360.062,9.2996338864; 360.562,9.2914023728; 361.059,9.2625920752;
            361.564,9.246129048; 362.063,9.3202126704; 362.558,9.2831708592;
            363.061,9.225550264; 363.563,9.2914023728; 364.062,9.2132029936;
            364.561,9.2543605616; 365.061,9.266707832; 365.56,9.2708235888;
            366.063,9.2831708592; 366.56,9.2584763184; 367.062,9.2502448048;
            367.562,9.2708235888; 368.062,9.2996338864; 368.562,9.2708235888;
            369.063,9.2914023728; 369.558,9.3160969136; 370.061,9.3078654;
            370.563,9.3325599408; 371.063,9.3037496432; 371.561,9.3037496432;
            372.064,9.3654859952; 372.561,9.349022968; 373.062,9.328444184;
            373.563,9.2831708592; 374.061,9.2584763184; 374.561,9.3119811568;
            375.061,9.2996338864; 375.562,9.3119811568; 376.063,9.2955181296;
            376.562,9.3531387248; 377.061,9.2996338864; 377.561,9.3366756976;
            378.061,9.3119811568; 378.561,9.3613702384; 379.062,9.3325599408;
            379.562,9.3572544816; 380.062,9.3654859952; 380.561,9.3737175088;
            381.063,9.2914023728; 381.563,9.3119811568; 382.062,9.3078654;
            382.564,9.3202126704; 383.062,9.287286616; 383.561,9.3037496432;
            384.062,9.3202126704; 384.562,9.3531387248; 385.062,9.3160969136;
            385.564,9.3942962928; 386.062,9.3531387248; 386.562,9.4025278064;
            387.062,9.4395696176; 387.562,9.4025278064; 388.063,9.4272223472;
            388.563,9.3860647792; 389.063,9.3449072112; 389.562,9.3325599408;
            390.063,9.3366756976; 390.562,9.287286616; 391.064,9.3243284272;
            391.562,9.3119811568; 392.063,9.2132029936; 392.561,9.2008557232;
            393.063,9.2584763184; 393.563,9.20497148; 394.064,9.2420132912;
            394.563,9.2214345072; 395.062,9.20497148; 395.563,9.1967399664;
            396.064,9.225550264; 396.563,9.2008557232; 397.062,9.266707832;
            397.562,9.2955181296; 398.062,9.287286616; 398.564,9.3202126704;
            399.061,9.2996338864; 399.562,9.3037496432; 400.063,9.2708235888;
            400.563,9.2790551024; 401.062,9.2749393456; 401.559,9.2996338864;
            402.063,9.3160969136; 402.561,9.3243284272; 403.062,9.3243284272;
            403.56,9.2378975344; 404.061,9.2749393456; 404.562,9.2708235888;
            405.062,9.2173187504; 405.563,9.2749393456; 406.059,9.2584763184;
            406.562,9.3119811568; 407.062,9.2749393456; 407.559,9.2831708592;
            408.062,9.3160969136; 408.562,9.287286616; 409.062,9.3243284272;
            409.562,9.3243284272; 410.062,9.3778332656; 410.562,9.3654859952;
            411.062,9.3819490224; 411.563,9.3407914544; 412.063,9.3819490224;
            412.563,9.369601752; 413.062,9.3572544816; 413.562,9.3860647792;
            414.062,9.4189908336; 414.562,9.3613702384; 415.061,9.3778332656;
            415.562,9.3531387248; 416.062,9.3737175088; 416.562,9.3449072112;
            417.06,9.390180536; 417.561,9.3325599408; 418.058,9.3243284272;
            418.561,9.3243284272; 419.063,9.266707832; 419.563,9.3160969136;
            420.062,9.3325599408; 420.563,9.3119811568; 421.064,9.3325599408;
            421.563,9.3984120496; 422.06,9.41075932; 422.562,9.3572544816;
            423.059,9.3778332656; 423.562,9.4066435632; 424.064,9.390180536;
            424.562,9.3654859952; 425.062,9.2996338864; 425.563,9.3119811568;
            426.062,9.3078654; 426.562,9.3572544816; 427.06,9.4025278064;
            427.564,9.3654859952; 428.061,9.2955181296; 428.561,9.3325599408;
            429.063,9.3366756976; 429.561,9.3654859952; 430.062,9.3819490224;
            430.561,9.349022968; 431.062,9.3572544816; 431.562,9.3613702384;
            432.058,9.3449072112; 432.564,9.3366756976; 433.064,9.328444184;
            433.563,9.3531387248; 434.062,9.3407914544; 434.563,9.3737175088;
            435.062,9.349022968; 435.563,9.328444184; 436.061,9.369601752;
            436.562,9.2996338864; 437.059,9.3572544816; 437.56,9.3325599408;
            438.193,9.3572544816; 438.559,9.3449072112; 439.062,9.3778332656;
            439.563,9.390180536; 440.074,9.3572544816; 440.561,9.3860647792;
            441.06,9.3778332656; 441.563,9.3613702384; 442.061,9.3366756976;
            442.562,9.3654859952; 443.064,9.3737175088; 443.561,9.3778332656;
            444.064,9.3778332656; 444.563,9.3860647792; 445.075,9.3202126704;
            445.573,9.328444184; 446.063,9.2996338864; 446.582,9.369601752;
            447.061,9.3778332656; 447.564,9.4395696176; 448.064,9.4189908336;
            448.562,9.3984120496; 449.062,9.349022968; 449.559,9.3531387248;
            450.059,9.3531387248; 450.563,9.3202126704; 451.062,9.3449072112;
            451.563,9.2708235888; 452.059,9.3572544816; 452.564,9.3160969136;
            453.06,9.2955181296; 453.561,9.2955181296; 454.06,9.3366756976;
            454.56,9.3325599408; 455.06,9.3572544816; 455.558,9.3572544816;
            456.06,9.4025278064; 456.562,9.3942962928; 457.059,9.390180536;
            457.564,9.4148750768; 458.061,9.472495672; 458.561,9.472495672;
            459.06,9.4683799152; 459.562,9.4560326448; 460.06,9.4889586992;
            460.56,9.451916888; 461.062,9.3819490224; 461.562,9.4272223472;
            462.066,9.287286616; 462.569,9.2996338864; 463.06,9.3160969136;
            463.562,9.2914023728; 464.063,9.3037496432; 464.561,9.3654859952;
            465.06,9.3407914544; 465.563,9.3160969136; 466.06,9.3160969136;
            466.562,9.287286616; 467.061,9.266707832; 467.563,9.2996338864;
            468.062,9.3078654; 468.564,9.3078654; 469.064,9.3819490224; 469.563,
            9.3654859952; 470.063,9.3737175088; 470.562,9.3737175088; 471.062,
            9.4231065904; 471.563,9.4436853744; 472.06,9.431338104; 472.563,
            9.390180536; 473.06,9.4025278064; 473.563,9.3737175088; 474.063,
            9.3613702384; 474.559,9.390180536; 475.062,9.3654859952; 475.563,
            9.4189908336; 476.062,9.369601752; 476.562,9.4148750768; 477.06,
            9.41075932; 477.562,9.41075932; 478.062,9.4066435632; 478.562,
            9.4148750768; 479.061,9.4025278064; 479.562,9.369601752; 480.064,
            9.4066435632; 480.563,9.3984120496; 481.061,9.4189908336; 481.563,
            9.4231065904; 482.061,9.3572544816; 482.563,9.3407914544; 483.062,
            9.3202126704; 483.562,9.3243284272; 484.061,9.3037496432; 484.563,
            9.3366756976; 485.061,9.3654859952; 485.562,9.4148750768; 486.061,
            9.3984120496; 486.561,9.4231065904; 487.062,9.4189908336; 487.562,
            9.4272223472; 488.061,9.4148750768; 488.563,9.41075932; 489.063,
            9.3860647792; 489.563,9.3942962928; 490.062,9.3860647792; 490.563,
            9.4848429424; 491.063,9.4478011312; 491.562,9.4148750768; 492.061,
            9.4436853744; 492.562,9.4066435632; 493.062,9.4272223472; 493.562,
            9.431338104; 494.061,9.431338104; 494.562,9.3819490224; 495.062,
            9.390180536; 495.562,9.3449072112; 496.062,9.349022968; 496.563,
            9.349022968; 497.063,9.3737175088; 497.561,9.3449072112; 498.063,
            9.3613702384; 498.563,9.4066435632; 499.063,9.3860647792; 499.562,
            9.3942962928; 500.062,9.390180536; 500.561,9.3407914544; 501.063,
            9.3531387248; 501.563,9.3160969136; 502.062,9.3366756976; 502.562,
            9.3531387248; 503.061,9.3407914544; 503.563,9.3860647792; 504.063,
            9.3860647792; 504.562,9.4231065904; 505.062,9.3778332656; 505.565,
            9.3860647792; 506.062,9.3613702384; 506.563,9.390180536; 507.06,
            9.4189908336; 507.562,9.349022968; 508.064,9.3778332656; 508.564,
            9.4395696176; 509.061,9.4231065904; 509.562,9.3942962928; 510.059,
            9.369601752; 510.563,9.41075932; 511.062,9.3819490224; 511.56,
            9.3778332656; 512.062,9.431338104; 512.561,9.4189908336; 513.061,
            9.431338104; 513.564,9.4189908336; 514.059,9.4971902128; 514.562,
            9.4601484016; 515.059,9.493074456; 515.564,9.4560326448; 516.064,
            9.328444184; 516.563,9.3449072112; 517.06,9.3366756976; 517.562,
            9.2996338864; 518.062,9.328444184; 518.562,9.3160969136; 519.062,
            9.3737175088; 519.562,9.3160969136; 520.062,9.3202126704; 520.564,
            9.3613702384; 521.062,9.4642641584; 521.563,9.4272223472; 522.061,
            9.431338104; 522.562,9.4395696176; 523.06,9.4766114288; 523.563,
            9.5095374832; 524.063,9.493074456; 524.561,9.4971902128; 525.062,
            9.4683799152; 525.562,9.431338104; 526.062,9.3531387248; 526.561,
            9.3366756976; 527.063,9.2955181296; 527.562,9.3449072112; 528.06,
            9.3737175088; 528.574,9.431338104; 529.061,9.349022968; 529.562,
            9.3984120496; 530.063,9.3778332656; 530.562,9.4189908336; 531.061,
            9.4395696176; 531.562,9.4642641584; 532.064,9.4683799152; 532.561,
            9.4231065904; 533.063,9.4189908336; 533.558,9.4025278064; 534.063,
            9.4272223472; 534.561,9.390180536; 535.061,9.3942962928; 535.563,
            9.3819490224; 536.062,9.390180536; 536.563,9.3449072112; 537.062,
            9.390180536; 537.561,9.3860647792; 538.061,9.3860647792; 538.559,
            9.4148750768; 539.064,9.3984120496; 539.561,9.4189908336; 540.061,
            9.3819490224; 540.562,9.3613702384; 541.063,9.3860647792; 541.563,
            9.390180536; 542.063,9.4231065904; 542.562,9.3778332656; 543.064,
            9.4148750768; 543.561,9.3449072112; 544.063,9.3819490224; 544.561,
            9.4683799152; 545.062,9.431338104; 545.562,9.4436853744; 546.061,
            9.41075932; 546.563,9.4807271856; 547.061,9.41075932; 547.561,
            9.3942962928; 548.062,9.4436853744; 548.562,9.4354538608; 549.062,
            9.4231065904; 549.564,9.4231065904; 550.062,9.41075932; 550.561,
            9.369601752; 551.062,9.369601752; 551.561,9.390180536; 552.063,
            9.3449072112; 552.56,9.4478011312; 553.063,9.4272223472; 553.562,
            9.3942962928; 554.062,9.4642641584; 554.562,9.41075932; 555.062,
            9.3942962928; 555.562,9.390180536; 556.063,9.4231065904; 556.563,
            9.431338104; 557.064,9.472495672; 557.561,9.4601484016; 558.059,
            9.4848429424; 558.563,9.5671580784; 559.06,9.5506950512; 559.563,
            9.5095374832; 560.062,9.4683799152; 560.563,9.3737175088; 561.063,
            9.3572544816; 561.56,9.390180536; 562.177,9.4066435632; 562.563,
            9.3572544816; 563.062,9.349022968; 563.562,9.3737175088; 564.062,
            9.4066435632; 564.562,9.4025278064; 565.062,9.3613702384; 565.563,
            9.4066435632; 566.063,9.3737175088; 566.563,9.4066435632; 567.061,
            9.4066435632; 567.563,9.4272223472; 568.064,9.4066435632; 568.562,
            9.4272223472; 569.063,9.4066435632; 569.563,9.4189908336; 570.062,
            9.4272223472; 570.562,9.3984120496; 571.062,9.4354538608; 571.564,
            9.4354538608; 572.062,9.451916888; 572.563,9.451916888; 573.062,
            9.4395696176; 573.561,9.4395696176; 574.059,9.5054217264; 574.564,
            9.431338104; 575.063,9.4189908336; 575.561,9.3984120496; 576.06,
            9.3860647792; 576.56,9.3613702384; 577.06,9.4889586992; 577.56,
            9.4272223472; 578.058,9.4560326448; 578.56,9.4642641584; 579.06,
            9.4560326448; 579.559,9.3860647792; 580.063,9.349022968; 580.563,
            9.349022968; 581.063,9.3860647792; 581.56,9.3942962928; 582.062,
            9.4807271856; 582.562,9.5095374832; 583.062,9.4766114288; 583.563,
            9.4766114288; 584.061,9.4601484016; 584.562,9.451916888; 585.062,
            9.4354538608; 585.563,9.4478011312; 586.061,9.4766114288; 586.564,
            9.4272223472; 587.062,9.4148750768; 587.561,9.4231065904; 588.061,
            9.4231065904; 588.562,9.4189908336; 589.062,9.4478011312; 589.562,
            9.41075932; 590.063,9.4354538608; 590.563,9.4066435632; 591.063,
            9.3737175088; 591.562,9.4148750768; 592.063,9.3942962928; 592.562,
            9.3819490224; 593.063,9.3860647792; 593.562,9.369601752; 594.063,
            9.4272223472; 594.563,9.431338104; 595.063,9.4395696176; 595.56,
            9.451916888; 596.062,9.4189908336; 596.563,9.4189908336; 597.063,
            9.4066435632; 597.562,9.4560326448; 598.06,9.4395696176; 598.562,
            9.4971902128; 599.063,9.4642641584; 599.562,9.451916888; 600.064,
            9.4189908336; 600.562,9.431338104; 601.062,9.390180536; 601.561,
            9.4560326448; 602.062,9.4025278064; 602.563,9.431338104; 603.062,
            9.4231065904; 603.561,9.4683799152; 604.064,9.4231065904; 604.562,
            9.431338104; 605.061,9.4231065904; 605.564,9.4436853744; 606.063,
            9.4683799152; 606.563,9.4560326448; 607.063,9.4601484016; 607.562,
            9.5177689968; 608.063,9.4189908336; 608.561,9.4189908336; 609.061,
            9.4231065904; 609.564,9.3860647792; 610.062,9.451916888; 610.563,
            9.451916888; 611.062,9.3984120496; 611.562,9.4189908336; 612.062,
            9.390180536; 612.563,9.3737175088; 613.061,9.3572544816; 613.562,
            9.3737175088; 614.064,9.4025278064; 614.563,9.4272223472; 615.062,
            9.4025278064; 615.562,9.4354538608; 616.062,9.41075932; 616.563,
            9.4560326448; 617.063,9.4436853744; 617.564,9.4395696176; 618.061,
            9.5301162672; 618.561,9.493074456; 619.062,9.4683799152; 619.563,
            9.4231065904; 620.063,9.4766114288; 620.56,9.4148750768; 621.063,
            9.4395696176; 621.56,9.4642641584; 622.061,9.390180536; 622.562,
            9.4601484016; 623.06,9.390180536; 623.562,9.4066435632; 624.063,
            9.4560326448; 624.56,9.4478011312; 625.063,9.3819490224; 625.563,
            9.4272223472; 626.064,9.451916888; 626.563,9.4231065904; 627.062,
            9.328444184; 627.563,9.390180536; 628.062,9.4766114288; 628.562,
            9.5177689968; 629.062,9.4642641584; 629.561,9.5424635376; 630.062,
            9.5671580784; 630.563,9.5177689968; 631.062,9.4848429424; 631.561,
            9.575389592; 632.062,9.5054217264; 632.561,9.5795053488; 633.062,
            9.554810808; 633.562,9.472495672; 634.06,9.5013059696; 634.562,
            9.431338104; 635.058,9.4889586992; 635.562,9.4807271856; 636.062,
            9.41075932; 636.559,9.4272223472; 637.06,9.41075932; 637.562,
            9.3654859952; 638.062,9.369601752; 638.562,9.4189908336; 639.063,
            9.4231065904; 639.562,9.4354538608; 640.062,9.4148750768; 640.563,
            9.4642641584; 641.063,9.4642641584; 641.564,9.5177689968; 642.063,
            9.4848429424; 642.562,9.5260005104; 643.06,9.5218847536; 643.562,
            9.5095374832; 644.062,9.4683799152; 644.561,9.4971902128; 645.064,
            9.5054217264; 645.563,9.4889586992; 646.062,9.5383477808; 646.564,
            9.5424635376; 647.063,9.534232024; 647.56,9.5506950512; 648.063,
            9.5877368624; 648.562,9.5260005104; 649.063,9.5013059696; 649.562,
            9.4807271856; 650.063,9.4189908336; 650.559,9.4231065904; 651.062,
            9.3778332656; 651.559,9.369601752; 652.06,9.3819490224; 652.563,
            9.4148750768; 653.062,9.4766114288; 653.564,9.5013059696; 654.062,
            9.5095374832; 654.563,9.5095374832; 655.062,9.5013059696; 655.562,
            9.390180536; 656.06,9.451916888; 656.563,9.390180536; 657.063,
            9.4272223472; 657.561,9.3984120496; 658.062,9.3942962928; 658.559,
            9.3984120496; 659.06,9.4066435632; 659.559,9.4272223472; 660.06,
            9.4560326448; 660.561,9.3819490224; 661.06,9.4560326448; 661.56,
            9.3860647792; 662.059,9.41075932; 662.564,9.4354538608; 663.064,
            9.4066435632; 663.56,9.41075932; 664.063,9.3819490224; 664.562,
            9.4189908336; 665.06,9.4189908336; 665.56,9.390180536; 666.06,
            9.41075932; 666.56,9.369601752; 667.06,9.41075932; 667.56,
            9.4436853744; 668.06,9.4354538608; 668.56,9.4272223472; 669.06,
            9.4189908336; 669.562,9.5054217264; 670.062,9.4272223472; 670.563,
            9.493074456; 671.059,9.4807271856; 671.563,9.451916888; 672.062,
            9.4354538608; 672.559,9.4272223472; 673.06,9.5218847536; 673.56,
            9.4601484016; 674.059,9.51365324; 674.56,9.5054217264; 675.06,
            9.493074456; 675.56,9.4807271856; 676.06,9.4601484016; 676.56,
            9.4436853744; 677.06,9.4766114288; 677.562,9.4766114288; 678.062,
            9.4436853744; 678.563,9.4807271856; 679.064,9.4272223472; 679.562,
            9.5218847536; 680.062,9.5095374832; 680.563,9.493074456; 681.063,
            9.5424635376; 681.559,9.5054217264; 682.062,9.5383477808; 682.561,
            9.4560326448; 683.063,9.41075932; 683.56,9.451916888; 684.063,
            9.3819490224; 684.564,9.4025278064; 685.062,9.4189908336; 685.564,
            9.451916888; 686.062,9.431338104; 686.56,9.4889586992; 687.063,
            9.575389592; 687.561,9.5712738352; 688.06,9.5218847536; 688.561,
            9.5795053488; 689.059,9.5630423216; 689.559,9.5630423216; 690.064,
            9.5630423216; 690.563,9.4889586992; 691.061,9.4642641584; 691.564,
            9.4272223472; 692.059,9.4272223472; 692.561,9.3942962928; 693.06,
            9.4148750768; 693.562,9.5013059696; 694.061,9.4601484016; 694.559,
            9.451916888; 695.06,9.4766114288; 695.56,9.3860647792; 696.062,
            9.4066435632; 696.561,9.3778332656; 697.061,9.3984120496; 697.561,
            9.4189908336; 698.061,9.41075932; 698.559,9.4601484016; 699.062,
            9.4601484016; 699.562,9.4189908336; 700.062,9.3819490224; 700.562,
            9.4025278064; 701.062,9.4066435632; 701.562,9.41075932; 702.062,
            9.4148750768; 702.56,9.4848429424; 703.062,9.4601484016; 703.563,
            9.472495672; 704.063,9.493074456; 704.563,9.554810808; 705.063,
            9.5054217264; 705.562,9.5260005104; 706.063,9.5095374832; 706.563,
            9.4807271856; 707.063,9.5177689968; 707.559,9.5424635376; 708.063,
            9.4766114288; 708.56,9.5260005104; 709.061,9.4642641584; 709.56,
            9.4436853744; 710.059,9.4766114288; 710.56,9.4683799152; 711.059,
            9.4807271856; 711.561,9.4766114288; 712.062,9.4642641584; 712.559,
            9.4807271856; 713.063,9.4601484016; 713.562,9.5054217264; 714.063,
            9.5260005104; 714.563,9.5013059696; 715.062,9.493074456; 715.563,
            9.4601484016; 716.062,9.4560326448; 716.562,9.5013059696; 717.063,
            9.5013059696; 717.559,9.5218847536; 718.063,9.4971902128; 718.562,
            9.51365324; 719.062,9.5589265648; 719.56,9.554810808; 720.06,
            9.5218847536; 720.562,9.5465792944; 721.064,9.4807271856; 721.563,
            9.4354538608; 722.063,9.451916888; 722.559,9.5424635376; 723.062,
            9.4807271856; 723.561,9.5218847536; 724.061,9.4807271856; 724.563,
            9.534232024; 725.062,9.5095374832; 725.562,9.5013059696; 726.061,
            9.4601484016; 726.562,9.5013059696; 727.063,9.4189908336; 727.56,
            9.4642641584; 728.061,9.4478011312; 728.56,9.4148750768; 729.063,
            9.451916888; 729.56,9.5054217264; 730.063,9.493074456; 730.562,
            9.5260005104; 731.063,9.575389592; 731.563,9.4971902128; 732.062,
            9.5054217264; 732.561,9.472495672; 733.062,9.4683799152; 733.562,
            9.4766114288; 734.062,9.4601484016; 734.564,9.472495672; 735.063,
            9.51365324; 735.56,9.5301162672; 736.062,9.4889586992; 736.56,
            9.4848429424; 737.063,9.4683799152; 737.56,9.451916888; 738.062,
            9.4766114288; 738.562,9.493074456; 739.062,9.4807271856; 739.561,
            9.4642641584; 740.062,9.5013059696; 740.562,9.5260005104; 741.062,
            9.5013059696; 741.563,9.4766114288; 742.063,9.472495672; 742.561,
            9.493074456; 743.063,9.5054217264; 743.562,9.5383477808; 744.062,
            9.5260005104; 744.56,9.5260005104; 745.061,9.4971902128; 745.563,
            9.4971902128; 746.061,9.5301162672; 746.562,9.5054217264; 747.061,
            9.4807271856; 747.56,9.493074456; 748.061,9.4766114288; 748.561,
            9.4848429424; 749.061,9.5465792944; 749.562,9.51365324; 750.061,
            9.5177689968; 750.56,9.5383477808; 751.062,9.5177689968; 751.559,
            9.493074456; 752.061,9.4642641584; 752.56,9.4642641584; 753.06,
            9.4560326448; 753.56,9.4436853744; 754.06,9.4436853744; 754.56,
            9.3572544816; 755.06,9.4148750768; 755.559,9.4971902128; 756.06,
            9.4889586992; 756.563,9.4807271856; 757.06,9.5054217264; 757.561,
            9.5177689968; 758.059,9.5177689968; 758.562,9.4848429424; 759.061,
            9.51365324; 759.563,9.5054217264; 760.063,9.5095374832; 760.563,
            9.5013059696; 761.062,9.51365324; 761.563,9.5795053488; 762.063,
            9.5177689968; 762.561,9.554810808; 763.06,9.5260005104; 763.563,
            9.5095374832; 764.063,9.4601484016; 764.562,9.4478011312; 765.063,
            9.3860647792; 765.56,9.3984120496; 766.063,9.349022968; 766.563,
            9.3654859952; 767.063,9.3737175088; 767.562,9.3984120496; 768.062,
            9.41075932; 768.562,9.4354538608; 769.063,9.431338104; 769.562,
            9.431338104; 770.062,9.493074456; 770.56,9.4642641584; 771.061,
            9.5177689968; 771.564,9.451916888; 772.063,9.4478011312; 772.563,
            9.431338104; 773.063,9.4601484016; 773.563,9.4436853744; 774.062,
            9.4436853744; 774.562,9.4231065904; 775.063,9.4436853744; 775.561,
            9.4272223472; 776.063,9.4354538608; 776.562,9.4395696176; 777.061,
            9.4066435632; 777.562,9.4272223472; 778.064,9.4231065904; 778.561,
            9.3654859952; 779.063,9.451916888; 779.567,9.3984120496; 780.063,
            9.4436853744; 780.562,9.4683799152; 781.063,9.5218847536; 781.562,
            9.6124314032; 782.062,9.6247786736; 782.564,9.5795053488; 783.063,
            9.5712738352; 783.563,9.5836211056; 784.065,9.5013059696; 784.563,
            9.5095374832; 785.063,9.5260005104; 785.562,9.5013059696; 786.063,
            9.472495672; 786.563,9.472495672; 787.062,9.4478011312; 787.563,
            9.4354538608; 788.062,9.4189908336; 788.561,9.4560326448; 789.06,
            9.4683799152; 789.56,9.4354538608; 790.062,9.4436853744; 790.561,
            9.4354538608; 791.06,9.4683799152; 791.56,9.4560326448; 792.059,
            9.4848429424; 792.56,9.4601484016; 793.059,9.4560326448; 793.562,
            9.4807271856; 794.061,9.51365324; 794.56,9.5260005104; 795.061,
            9.4601484016; 795.561,9.5013059696; 796.061,9.51365324; 796.56,
            9.4971902128; 797.062,9.5013059696; 797.561,9.5301162672; 798.061,
            9.451916888; 798.561,9.4971902128; 799.062,9.4807271856; 799.56,
            9.4807271856; 800.061,9.4848429424; 800.561,9.4395696176; 801.061,
            9.4189908336; 801.561,9.4231065904; 802.062,9.4683799152; 802.56,
            9.5095374832; 803.059,9.5013059696; 803.56,9.51365324; 804.061,
            9.4848429424; 804.561,9.4889586992; 805.061,9.5054217264; 805.561,
            9.4848429424; 806.061,9.4848429424; 806.561,9.4478011312; 807.061,
            9.4766114288; 807.561,9.4683799152; 808.06,9.472495672; 808.562,
            9.4766114288; 809.062,9.4683799152; 809.561,9.4436853744; 810.061,
            9.4642641584; 810.562,9.4642641584; 811.06,9.4189908336; 811.56,
            9.3819490224; 812.063,9.4066435632; 812.561,9.3860647792; 813.061,
            9.41075932; 813.562,9.3449072112; 814.062,9.431338104; 814.56,
            9.4395696176; 815.06,9.4272223472; 815.56,9.4560326448; 816.062,
            9.4766114288; 816.563,9.472495672; 817.06,9.5054217264; 817.56,
            9.5260005104; 818.06,9.4683799152; 818.56,9.5424635376; 819.061,
            9.5465792944; 819.56,9.5424635376; 820.06,9.472495672; 820.561,
            9.4848429424; 821.061,9.4971902128; 821.56,9.4971902128; 822.061,
            9.4601484016; 822.561,9.5013059696; 823.061,9.451916888; 823.56,
            9.5013059696; 824.061,9.4971902128; 824.56,9.493074456; 825.059,
            9.4889586992; 825.56,9.4066435632; 826.06,9.4601484016; 826.56,
            9.431338104; 827.061,9.493074456; 827.561,9.4889586992; 828.06,
            9.451916888; 828.561,9.4395696176; 829.06,9.4272223472; 829.562,
            9.4478011312; 830.061,9.472495672; 830.561,9.4642641584; 831.06,
            9.472495672; 831.56,9.4354538608; 832.061,9.4272223472; 832.56,
            9.4395696176; 833.063,9.4560326448; 833.56,9.4560326448; 834.061,
            9.4807271856; 834.561,9.4478011312; 835.063,9.4560326448; 835.56,
            9.4395696176; 836.061,9.4601484016; 836.561,9.4560326448; 837.06,
            9.451916888; 837.563,9.4560326448; 838.062,9.472495672; 838.561,
            9.3942962928; 839.062,9.4148750768; 839.561,9.3572544816; 840.063,
            9.369601752; 840.559,9.3778332656; 841.061,9.369601752; 841.562,
            9.349022968; 842.064,9.3860647792; 842.561,9.4231065904; 843.061,
            9.3737175088; 843.564,9.4436853744; 844.063,9.4066435632; 844.563,
            9.4272223472; 845.062,9.3860647792; 845.56,9.4560326448; 846.064,
            9.472495672; 846.562,9.472495672; 847.064,9.4560326448; 847.56,
            9.431338104; 848.064,9.451916888; 848.563,9.4189908336; 849.063,
            9.4807271856; 849.563,9.4642641584; 850.06,9.4560326448; 850.562,
            9.4766114288; 851.062,9.4478011312; 851.563,9.3984120496; 852.063,
            9.3819490224; 852.561,9.3942962928; 853.061,9.4231065904; 853.564,
            9.3984120496; 854.064,9.4478011312; 854.562,9.4354538608; 855.062,
            9.472495672; 855.564,9.4436853744; 856.061,9.4189908336; 856.563,
            9.4807271856; 857.063,9.4395696176; 857.564,9.4848429424; 858.064,
            9.4354538608; 858.561,9.4889586992; 859.063,9.4272223472; 859.562,
            9.4560326448; 860.063,9.4189908336; 860.563,9.4231065904; 861.06,
            9.3778332656; 861.562,9.4231065904; 862.065,9.4601484016; 862.564,
            9.4478011312; 863.061,9.4889586992; 863.563,9.4395696176; 864.063,
            9.431338104; 864.561,9.4354538608; 865.062,9.4148750768; 865.564,
            9.4354538608; 866.063,9.4025278064; 866.561,9.3984120496; 867.062,
            9.41075932; 867.563,9.3942962928; 868.062,9.4272223472; 868.562,
            9.4436853744; 869.063,9.4766114288; 869.562,9.4478011312; 870.063,
            9.4889586992; 870.56,9.5095374832; 871.064,9.5301162672; 871.564,
            9.4395696176; 872.062,9.4272223472; 872.562,9.41075932; 873.063,
            9.390180536; 873.562,9.4354538608; 874.062,9.4683799152; 874.56,
            9.4601484016; 875.064,9.4642641584; 875.562,9.51365324; 876.064,
            9.4807271856; 876.563,9.4971902128; 877.063,9.5465792944; 877.562,
            9.5013059696; 878.063,9.4971902128; 878.564,9.5836211056; 879.062,
            9.5095374832; 879.563,9.554810808; 880.063,9.4889586992; 880.564,
            9.5424635376; 881.061,9.5630423216; 881.563,9.5095374832; 882.063,
            9.5424635376; 882.564,9.5589265648; 883.063,9.5795053488; 883.562,
            9.575389592; 884.065,9.5260005104; 884.563,9.5301162672; 885.063,
            9.5383477808; 885.564,9.5506950512; 886.064,9.5671580784; 886.562,
            9.595968376; 887.063,9.6247786736; 887.564,9.5877368624; 888.062,
            9.5424635376; 888.563,9.5465792944; 889.063,9.5424635376; 889.564,
            9.5465792944; 890.063,9.5383477808; 890.562,9.51365324; 891.062,
            9.5424635376; 891.563,9.5671580784; 892.063,9.5795053488; 892.564,
            9.595968376; 893.063,9.5424635376; 893.564,9.5712738352; 894.063,
            9.5671580784; 894.563,9.6000841328; 895.062,9.5671580784; 895.565,
            9.5465792944; 896.062,9.5260005104; 896.563,9.5301162672; 897.063,
            9.5630423216; 897.565,9.5424635376; 898.062,9.5177689968; 898.563,
            9.5260005104; 899.064,9.4971902128; 899.563,9.4848429424; 900.063,
            9.5095374832; 900.563,9.4971902128; 901.063,9.51365324; 901.564,
            9.5260005104; 902.065,9.5424635376; 902.562,9.5383477808; 903.063,
            9.4272223472; 903.564,9.4436853744; 904.063,9.5260005104; 904.563,
            9.4601484016; 905.063,9.431338104; 905.562,9.4971902128; 906.063,
            9.451916888; 906.562,9.4971902128; 907.062,9.5260005104; 907.564,
            9.4889586992; 908.064,9.5301162672; 908.564,9.4971902128; 909.062,
            9.51365324; 909.563,9.5177689968; 910.062,9.51365324; 910.56,
            9.4971902128; 911.063,9.554810808; 911.563,9.5465792944; 912.064,
            9.534232024; 912.562,9.5095374832; 913.063,9.534232024; 913.563,
            9.5671580784; 914.063,9.5506950512; 914.564,9.5424635376; 915.064,
            9.5218847536; 915.563,9.5506950512; 916.063,9.6083156464; 916.564,
            9.554810808; 917.063,9.5918526192; 917.565,9.5795053488; 918.063,
            9.5465792944; 918.564,9.534232024; 919.065,9.493074456; 919.564,
            9.5383477808; 920.065,9.5506950512; 920.562,9.5918526192; 921.063,
            9.5177689968; 921.565,9.5712738352; 922.063,9.6041998896; 922.564,
            9.5836211056; 923.065,9.5795053488; 923.562,9.575389592; 924.062,
            9.5506950512; 924.564,9.5918526192; 925.061,9.6124314032; 925.562,
            9.6083156464; 926.062,9.6330101872; 926.559,9.6535889712; 927.063,
            9.6741677552; 927.565,9.6453574576; 928.063,9.61654716; 928.563,
            9.61654716; 929.064,9.6124314032; 929.563,9.6083156464; 930.064,
            9.7070938096; 930.564,9.678283512; 931.064,9.6247786736; 931.563,
            9.5795053488; 932.064,9.5424635376; 932.563,9.5877368624; 933.064,
            9.6000841328; 933.564,9.595968376; 934.062,9.6124314032; 934.563,
            9.6124314032; 935.063,9.6494732144; 935.562,9.6000841328; 936.063,
            9.5506950512; 936.56,9.5506950512; 937.06,9.554810808; 937.563,
            9.5383477808; 938.063,9.5712738352; 938.563,9.5589265648; 939.065,
            9.61654716; 939.565,9.5589265648; 940.064,9.5301162672; 940.563,
            9.554810808; 941.065,9.5589265648; 941.562,9.5795053488; 942.065,
            9.5465792944; 942.562,9.5918526192; 943.063,9.6041998896; 943.563,
            9.5506950512; 944.063,9.595968376; 944.565,9.5465792944; 945.063,
            9.5630423216; 945.563,9.5301162672; 946.064,9.534232024; 946.563,
            9.5301162672; 947.062,9.575389592; 947.565,9.5630423216; 948.063,
            9.5630423216; 948.564,9.5712738352; 949.065,9.5589265648; 949.564,
            9.5671580784; 950.06,9.5465792944; 950.564,9.5589265648; 951.065,
            9.5918526192; 951.56,9.5630423216; 952.06,9.6124314032; 952.563,
            9.575389592; 953.062,9.5712738352; 953.563,9.5877368624; 954.064,
            9.5301162672; 954.563,9.4683799152; 955.062,9.5095374832; 955.563,
            9.4272223472; 956.063,9.51365324; 956.561,9.5383477808; 957.063,
            9.493074456; 957.563,9.534232024; 958.062,9.5630423216; 958.564,
            9.5671580784; 959.064,9.595968376; 959.563,9.5836211056; 960.063,
            9.6412417008; 960.562,9.5424635376; 961.062,9.6041998896; 961.563,
            9.5877368624; 962.061,9.595968376; 962.561,9.6000841328; 963.064,
            9.6041998896; 963.562,9.6206629168; 964.062,9.5877368624; 964.564,
            9.637125944; 965.063,9.575389592; 965.561,9.4642641584; 966.064,
            9.493074456; 966.562,9.5177689968; 967.063,9.554810808; 967.565,
            9.6947465392; 968.062,9.7441356208; 968.563,9.7359041072; 969.061,
            9.7112095664; 969.563,9.7359041072; 970.063,9.7070938096; 970.564,
            9.698862296; 971.064,9.6494732144; 971.563,9.7153253232; 972.063,
            9.7317883504; 972.563,9.7070938096; 973.061,9.7070938096; 973.563,
            9.6412417008; 974.063,9.5465792944; 974.564,9.6124314032; 975.063,
            9.6535889712; 975.563,9.6412417008; 976.063,9.6535889712; 976.562,
            9.657704728; 977.064,9.5506950512; 977.563,9.595968376; 978.064,
            9.6247786736; 978.563,9.595968376; 979.065,9.5630423216; 979.563,
            9.5671580784; 980.064,9.6041998896; 980.564,9.6000841328; 981.061,
            9.5506950512; 981.563,9.5013059696; 982.063,9.5506950512; 982.563,
            9.575389592; 983.063,9.4848429424; 983.564,9.5301162672; 984.064,
            9.5712738352; 984.564,9.5506950512; 985.065,9.5712738352; 985.562,
            9.554810808; 986.063,9.6041998896; 986.565,9.5589265648; 987.064,
            9.5506950512; 987.563,9.6247786736; 988.062,9.5877368624; 988.564,
            9.6412417008; 989.064,9.5877368624; 989.564,9.5506950512; 990.064,
            9.5260005104; 990.563,9.6247786736; 991.064,9.5260005104; 991.56,
            9.6000841328; 992.063,9.6288944304; 992.563,9.6247786736; 993.064,
            9.5465792944; 993.563,9.5836211056; 994.062,9.5506950512; 994.564,
            9.6000841328; 995.063,9.5424635376; 995.563,9.5589265648; 996.062,
            9.5712738352; 996.563,9.6247786736; 997.064,9.5301162672; 997.564,
            9.575389592; 998.063,9.6330101872; 998.563,9.6247786736; 999.062,
            9.6659362416; 999.564,9.6494732144; 1000.065,9.6494732144; 1000.564,
            9.6535889712; 1001.063,9.6330101872; 1001.565,9.657704728; 1002.064,
            9.5836211056; 1002.565,9.6247786736; 1003.062,9.6823992688;
            1003.564,9.6823992688; 1004.063,9.7317883504; 1004.564,9.6247786736;
            1005.063,9.657704728; 1005.564,9.7029780528; 1006.062,9.6000841328;
            1006.564,9.6124314032; 1007.063,9.6124314032; 1007.562,9.575389592;
            1008.061,9.5836211056; 1008.565,9.61654716; 1009.063,9.5795053488;
            1009.564,9.6453574576; 1010.063,9.5260005104; 1010.563,9.595968376;
            1011.063,9.5877368624; 1011.562,9.5630423216; 1012.063,9.5589265648;
            1012.564,9.6083156464; 1013.062,9.6124314032; 1013.562,9.6700519984;
            1014.063,9.6741677552; 1014.564,9.5630423216; 1015.063,9.6083156464;
            1015.563,9.6535889712; 1016.064,9.6330101872; 1016.563,9.637125944;
            1017.063,9.6494732144; 1017.562,9.6206629168; 1018.06,9.6288944304;
            1018.563,9.575389592; 1019.063,9.61654716; 1019.563,9.575389592;
            1020.064,9.6000841328; 1020.564,9.595968376; 1021.063,9.61654716;
            1021.563,9.6206629168; 1022.062,9.575389592; 1022.562,9.5424635376;
            1023.06,9.5383477808; 1023.564,9.5671580784; 1024.065,9.595968376;
            1024.563,9.6700519984; 1025.064,9.698862296; 1025.563,9.6823992688;
            1026.064,9.6659362416; 1026.565,9.6741677552; 1027.063,9.6124314032;
            1027.565,9.6247786736; 1028.06,9.6000841328; 1028.564,9.5836211056;
            1029.062,9.6288944304; 1029.564,9.657704728; 1030.064,9.5877368624;
            1030.564,9.6206629168; 1031.064,9.595968376; 1031.564,9.554810808;
            1032.063,9.6041998896; 1032.564,9.5795053488; 1033.06,9.6453574576;
            1033.563,9.6288944304; 1034.063,9.6453574576; 1034.564,9.6412417008;
            1035.064,9.6618204848; 1035.562,9.6206629168; 1036.064,9.6700519984;
            1036.564,9.6865150256; 1037.062,9.71944108; 1037.564,9.6494732144;
            1038.062,9.6906307824; 1038.563,9.6618204848; 1039.063,9.657704728;
            1039.563,9.6453574576; 1040.063,9.637125944; 1040.564,9.5671580784;
            1041.066,9.5836211056; 1041.562,9.5465792944; 1042.063,9.5054217264;
            1042.562,9.6041998896; 1043.064,9.5301162672; 1043.563,9.6288944304;
            1044.063,9.5671580784; 1044.561,9.6041998896; 1045.063,9.5877368624;
            1045.563,9.6494732144; 1046.064,9.5918526192; 1046.562,9.61654716;
            1047.063,9.6124314032; 1047.563,9.5671580784; 1048.062,9.6083156464;
            1048.562,9.6124314032; 1049.064,9.6247786736; 1049.563,9.5795053488;
            1050.062,9.575389592; 1050.563,9.575389592; 1051.063,9.5506950512;
            1051.564,9.6000841328; 1052.063,9.5630423216; 1052.563,9.575389592;
            1053.062,9.5877368624; 1053.563,9.5836211056; 1054.061,9.6206629168;
            1054.563,9.5877368624; 1055.064,9.6288944304; 1055.564,9.637125944;
            1056.064,9.6494732144; 1056.564,9.61654716; 1057.063,9.6659362416;
            1057.565,9.637125944; 1058.063,9.6535889712; 1058.565,9.6906307824;
            1059.064,9.6741677552; 1059.565,9.6659362416; 1060.062,9.6823992688;
            1060.563,9.7070938096; 1061.064,9.6823992688; 1061.563,9.678283512;
            1062.063,9.71944108; 1062.563,9.698862296; 1063.065,9.6741677552;
            1063.562,9.7359041072; 1064.063,9.678283512; 1064.564,9.6618204848;
            1065.063,9.6453574576; 1065.564,9.6330101872; 1066.064,9.6453574576;
            1066.565,9.6041998896; 1067.064,9.6206629168; 1067.565,9.61654716;
            1068.064,9.637125944; 1068.564,9.6494732144; 1069.064,9.6412417008;
            1069.564,9.6659362416; 1070.064,9.7276725936; 1070.564,9.6906307824;
            1071.064,9.7029780528; 1071.562,9.6412417008; 1072.063,9.6865150256;
            1072.565,9.6947465392; 1073.064,9.7317883504; 1073.564,9.6823992688;
            1074.063,9.7112095664; 1074.564,9.678283512; 1075.062,9.698862296;
            1075.562,9.7070938096; 1076.063,9.7482513776; 1076.562,9.7235568368;
            1077.064,9.7564828912; 1077.562,9.7647144048; 1078.063,9.7976404592;
            1078.562,9.781177432; 1079.064,9.7852931888; 1079.564,9.7935247024;
            1080.064,9.7770616752; 1080.562,9.7482513776; 1081.064,9.7317883504;
            1081.56,9.7647144048; 1082.064,9.7276725936; 1082.565,9.7153253232;
            1083.064,9.678283512; 1083.563,9.6412417008; 1084.064,9.6288944304;
            1084.562,9.6412417008; 1085.064,9.678283512; 1085.564,9.6659362416;
            1086.064,9.6535889712; 1086.564,9.6453574576; 1087.062,9.6494732144;
            1087.563,9.6247786736; 1088.062,9.6330101872; 1088.563,9.6494732144;
            1089.064,9.6947465392; 1089.562,9.7029780528; 1090.063,9.7235568368;
            1090.564,9.7112095664; 1091.065,9.698862296; 1091.561,9.6947465392;
            1092.063,9.6823992688; 1092.563,9.740019864; 1093.064,9.7112095664;
            1093.564,9.7317883504; 1094.064,9.7647144048; 1094.563,9.7688301616;
            1095.063,9.6947465392; 1095.563,9.6412417008; 1096.065,9.6618204848;
            1096.564,9.595968376; 1097.063,9.5795053488; 1097.564,9.6206629168;
            1098.062,9.6206629168; 1098.563,9.657704728; 1099.063,9.595968376;
            1099.563,9.6412417008; 1100.064,9.698862296; 1100.563,9.6947465392;
            1101.064,9.7317883504; 1101.564,9.7276725936; 1102.063,9.7029780528;
            1102.563,9.6700519984; 1103.063,9.678283512; 1103.565,9.6823992688;
            1104.064,9.6947465392; 1104.564,9.7482513776; 1105.065,9.7359041072;
            1105.562,9.7112095664; 1106.064,9.7317883504; 1106.563,9.740019864;
            1107.063,9.7729459184; 1107.561,9.7564828912; 1108.062,9.7070938096;
            1108.563,9.6618204848; 1109.061,9.7276725936; 1109.563,9.678283512;
            1110.063,9.698862296; 1110.562,9.71944108; 1111.061,9.6947465392;
            1111.56,9.7482513776; 1112.059,9.7112095664; 1112.561,9.7770616752;
            1113.06,9.7029780528; 1113.561,9.7441356208; 1114.062,9.6823992688;
            1114.56,9.7112095664; 1115.061,9.7070938096; 1115.561,9.740019864;
            1116.061,9.7070938096; 1116.562,9.7070938096; 1117.061,9.7441356208;
            1117.563,9.7359041072; 1118.063,9.6823992688; 1118.563,9.698862296;
            1119.064,9.6659362416; 1119.563,9.6618204848; 1120.063,9.637125944;
            1120.563,9.61654716; 1121.063,9.6206629168; 1121.563,9.5836211056;
            1122.063,9.61654716; 1122.565,9.6000841328; 1123.064,9.6535889712;
            1123.56,9.6494732144; 1124.063,9.6330101872; 1124.564,9.5877368624;
            1125.064,9.6083156464; 1125.564,9.6412417008; 1126.063,9.6618204848;
            1126.563,9.637125944; 1127.064,9.657704728; 1127.564,9.657704728;
            1128.064,9.6659362416; 1128.564,9.6288944304; 1129.063,9.61654716;
            1129.565,9.6206629168; 1130.064,9.6453574576; 1130.564,9.595968376;
            1131.064,9.595968376; 1131.565,9.6412417008; 1132.064,9.6000841328;
            1132.564,9.575389592; 1133.065,9.6083156464; 1133.562,9.637125944;
            1134.064,9.6906307824; 1134.563,9.7070938096; 1135.065,9.7112095664;
            1135.564,9.7070938096; 1136.064,9.7235568368; 1136.563,9.7070938096;
            1137.065,9.7153253232; 1137.565,9.698862296; 1138.064,9.6247786736;
            1138.562,9.6206629168; 1139.061,9.6041998896; 1139.564,9.6124314032;
            1140.063,9.61654716; 1140.564,9.657704728; 1141.064,9.6741677552;
            1141.564,9.6659362416; 1142.065,9.6865150256; 1142.563,9.637125944;
            1143.064,9.6823992688; 1143.564,9.6659362416; 1144.064,9.637125944;
            1144.563,9.6659362416; 1145.064,9.6535889712; 1145.563,9.657704728;
            1146.063,9.6741677552; 1146.565,9.6659362416; 1147.063,9.6535889712;
            1147.564,9.6741677552; 1148.063,9.6659362416; 1148.563,9.7029780528;
            1149.062,9.6700519984; 1149.563,9.7153253232; 1150.064,9.7153253232;
            1150.564,9.6823992688; 1151.063,9.6659362416; 1151.564,9.6700519984;
            1152.062,9.6618204848; 1152.565,9.6947465392; 1153.063,9.6865150256;
            1153.563,9.71944108; 1154.063,9.7112095664; 1154.564,9.678283512;
            1155.065,9.6906307824; 1155.564,9.6906307824; 1156.062,9.7276725936;
            1156.564,9.7112095664; 1157.065,9.7029780528; 1157.563,9.6741677552;
            1158.063,9.7029780528; 1158.563,9.7070938096; 1159.063,9.7523671344;
            1159.564,9.6906307824; 1160.063,9.6700519984; 1160.564,9.698862296;
            1161.065,9.7112095664; 1161.564,9.6865150256; 1162.062,9.6823992688;
            1162.564,9.7153253232; 1163.063,9.7317883504; 1163.563,9.678283512;
            1164.063,9.6906307824; 1164.564,9.657704728; 1165.063,9.6330101872;
            1165.562,9.6412417008; 1166.064,9.6247786736; 1166.56,9.657704728;
            1167.064,9.6535889712; 1167.56,9.7441356208; 1168.064,9.781177432;
            1168.563,9.7647144048; 1169.065,9.7564828912; 1169.563,9.7729459184;
            1170.062,9.7359041072; 1170.563,9.760598648; 1171.063,9.7523671344;
            1171.563,9.7235568368; 1172.062,9.6947465392; 1172.563,9.7276725936;
            1173.064,9.7235568368; 1173.564,9.6947465392; 1174.061,9.6659362416;
            1174.564,9.6865150256; 1175.065,9.6865150256; 1175.563,9.6906307824;
            1176.065,9.7688301616; 1176.564,9.7112095664; 1177.064,9.7770616752;
            1177.563,9.7482513776; 1178.063,9.7359041072; 1178.562,9.7523671344;
            1179.064,9.7523671344; 1179.563,9.7564828912; 1180.063,9.7729459184;
            1180.564,9.7276725936; 1181.065,9.698862296; 1181.563,9.6412417008;
            1182.064,9.657704728; 1182.563,9.698862296; 1183.064,9.7112095664;
            1183.563,9.678283512; 1184.06,9.6865150256; 1184.562,9.6700519984;
            1185.063,9.698862296; 1185.561,9.71944108; 1186.062,9.7112095664;
            1186.561,9.6865150256; 1187.064,9.6741677552; 1187.563,9.7688301616;
            1188.063,9.7317883504; 1188.563,9.760598648; 1189.064,9.7976404592;
            1189.563,9.781177432; 1190.064,9.7770616752; 1190.564,9.7688301616;
            1191.063,9.8141034864; 1191.563,9.7359041072; 1192.064,9.8099877296;
            1192.563,9.7729459184; 1193.065,9.8099877296; 1193.564,9.7976404592;
            1194.063,9.8058719728; 1194.564,9.7482513776; 1195.063,9.71944108;
            1195.562,9.698862296; 1196.064,9.7359041072; 1196.564,9.7317883504;
            1197.063,9.71944108; 1197.564,9.6865150256; 1198.064,9.7235568368;
            1198.563,9.657704728; 1199.065,9.6206629168; 1199.563,9.6618204848;
            1200.064,9.61654716; 1200.562,9.6412417008; 1201.064,9.6041998896;
            1201.564,9.6083156464; 1202.063,9.595968376; 1202.562,9.6000841328;
            1203.063,9.5836211056; 1203.563,9.595968376; 1204.062,9.6041998896;
            1204.565,9.6330101872; 1205.064,9.6947465392; 1205.564,9.6823992688;
            1206.063,9.7153253232; 1206.563,9.7153253232; 1207.063,9.6906307824;
            1207.563,9.6906307824; 1208.064,9.7276725936; 1208.563,9.71944108;
            1209.061,9.6823992688; 1209.564,9.6741677552; 1210.062,9.698862296;
            1210.56,9.6823992688; 1211.062,9.6700519984; 1211.562,9.6947465392;
            1212.062,9.6247786736; 1212.564,9.6330101872; 1213.062,9.6412417008;
            1213.564,9.637125944; 1214.064,9.6453574576; 1214.56,9.6700519984;
            1215.064,9.698862296; 1215.562,9.678283512; 1216.061,9.6741677552;
            1216.564,9.7276725936; 1217.065,9.6494732144; 1217.564,9.7112095664;
            1218.063,9.6618204848; 1218.564,9.698862296; 1219.063,9.7029780528;
            1219.563,9.7359041072; 1220.063,9.760598648; 1220.564,9.7729459184;
            1221.063,9.7235568368; 1221.562,9.781177432; 1222.063,9.7235568368;
            1222.562,9.7894089456; 1223.065,9.8058719728; 1223.562,9.7153253232;
            1224.064,9.6700519984; 1224.564,9.6659362416; 1225.064,9.6741677552;
            1225.564,9.6618204848; 1226.064,9.6865150256; 1226.562,9.6906307824;
            1227.062,9.6659362416; 1227.564,9.6535889712; 1228.063,9.7112095664;
            1228.561,9.6906307824; 1229.064,9.7153253232; 1229.565,9.7153253232;
            1230.064,9.7153253232; 1230.564,9.7112095664; 1231.064,9.7647144048;
            1231.564,9.71944108; 1232.063,9.781177432; 1232.564,9.7482513776;
            1233.064,9.7564828912; 1233.562,9.6865150256; 1234.062,9.6741677552;
            1234.566,9.6659362416; 1235.065,9.6535889712; 1235.564,9.6288944304;
            1236.065,9.575389592; 1236.563,9.6659362416; 1237.064,9.6618204848;
            1237.564,9.6865150256; 1238.063,9.7482513776; 1238.563,9.760598648;
            1239.064,9.7976404592; 1239.562,9.7770616752; 1240.064,9.7647144048;
            1240.564,9.7359041072; 1241.064,9.7770616752; 1241.564,9.7482513776;
            1242.063,9.7276725936; 1242.561,9.7070938096; 1243.063,9.740019864;
            1243.564,9.7029780528; 1244.063,9.71944108; 1244.565,9.7482513776;
            1245.064,9.7935247024; 1245.563,9.801756216; 1246.064,9.8387980272;
            1246.563,9.801756216; 1247.062,9.8346822704; 1247.564,9.7688301616;
            1248.065,9.7523671344; 1248.56,9.8141034864; 1249.065,9.7523671344;
            1249.563,9.7564828912; 1250.065,9.698862296; 1250.565,9.781177432;
            1251.062,9.7317883504; 1251.564,9.7647144048; 1252.065,9.7276725936;
            1252.562,9.7317883504; 1253.064,9.7029780528; 1253.563,9.7153253232;
            1254.064,9.6618204848; 1254.563,9.6947465392; 1255.065,9.740019864;
            1255.564,9.760598648; 1256.064,9.6906307824; 1256.563,9.7359041072;
            1257.063,9.7359041072; 1257.564,9.7112095664; 1258.064,9.7153253232;
            1258.562,9.7482513776; 1259.062,9.7153253232; 1259.566,9.7153253232;
            1260.064,9.7029780528; 1260.562,9.6659362416; 1261.063,9.6865150256;
            1261.564,9.6124314032; 1262.063,9.6453574576; 1262.563,9.6288944304;
            1263.063,9.61654716; 1263.562,9.6288944304; 1264.059,9.678283512;
            1264.561,9.6906307824; 1265.064,9.6906307824; 1265.564,9.6700519984;
            1266.063,9.7235568368; 1266.564,9.6412417008; 1267.063,9.657704728;
            1267.564,9.6700519984; 1268.063,9.7112095664; 1268.561,9.7317883504;
            1269.063,9.7153253232; 1269.564,9.760598648; 1270.065,9.6823992688;
            1270.563,9.7523671344; 1271.064,9.7359041072; 1271.563,9.760598648;
            1272.063,9.8058719728; 1272.563,9.7770616752; 1273.064,9.7482513776;
            1273.561,9.7894089456; 1274.063,9.7852931888; 1274.562,9.740019864;
            1275.063,9.7647144048; 1275.56,9.7359041072; 1276.064,9.781177432;
            1276.563,9.7482513776; 1277.063,9.7029780528; 1277.564,9.6906307824;
            1278.064,9.6906307824; 1278.561,9.6865150256; 1279.063,9.6906307824;
            1279.564,9.6947465392; 1280.063,9.6947465392; 1280.565,9.7112095664;
            1281.064,9.7359041072; 1281.563,9.7317883504; 1282.063,9.71944108;
            1282.562,9.6823992688; 1283.061,9.7070938096; 1283.561,9.7112095664;
            1284.064,9.7441356208; 1284.562,9.7235568368; 1285.064,9.7317883504;
            1285.563,9.71944108; 1286.065,9.7441356208; 1286.564,9.7276725936;
            1287.064,9.7647144048; 1287.564,9.6700519984; 1288.063,9.7482513776;
            1288.561,9.7647144048; 1289.063,9.6700519984; 1289.564,9.7359041072;
            1290.064,9.7070938096; 1290.563,9.7317883504; 1291.064,9.7523671344;
            1291.565,9.7359041072; 1292.064,9.6906307824; 1292.564,9.6906307824;
            1293.064,9.7359041072; 1293.562,9.7070938096; 1294.061,9.7441356208;
            1294.562,9.7852931888; 1295.065,9.781177432; 1295.563,9.7647144048;
            1296.061,9.7112095664; 1296.564,9.6823992688; 1297.064,9.7441356208;
            1297.563,9.7276725936; 1298.064,9.7564828912; 1298.565,9.7441356208;
            1299.064,9.7688301616; 1299.565,9.7112095664; 1300.061,9.740019864;
            1300.564,9.6659362416; 1301.064,9.6494732144; 1301.563,9.6453574576;
            1302.064,9.6124314032; 1302.564,9.6000841328; 1303.063,9.657704728;
            1303.564,9.678283512; 1304.064,9.7153253232; 1304.564,9.698862296;
            1305.063,9.7317883504; 1305.564,9.7153253232; 1306.065,9.698862296;
            1306.564,9.7153253232; 1307.064,9.7441356208; 1307.563,9.7523671344;
            1308.063,9.7688301616; 1308.563,9.7276725936; 1309.065,9.740019864;
            1309.563,9.6865150256; 1310.065,9.6823992688; 1310.563,9.7235568368;
            1311.066,9.6453574576; 1311.564,9.7029780528; 1312.065,9.71944108;
            1312.562,9.7235568368; 1313.064,9.7729459184; 1313.56,9.760598648;
            1314.065,9.7523671344; 1314.565,9.7070938096; 1315.063,9.6947465392;
            1315.564,9.6247786736; 1316.062,9.6535889712; 1316.564,9.698862296;
            1317.061,9.71944108; 1317.563,9.7317883504; 1318.064,9.6947465392;
            1318.563,9.7235568368; 1319.063,9.7688301616; 1319.563,9.7688301616;
            1320.063,9.7482513776; 1320.562,9.7482513776; 1321.064,9.7276725936;
            1321.565,9.7153253232; 1322.063,9.760598648; 1322.561,9.740019864;
            1323.063,9.7359041072; 1323.563,9.7564828912; 1324.064,9.6906307824;
            1324.561,9.657704728; 1325.063,9.5877368624; 1325.565,9.6453574576;
            1326.062,9.7070938096; 1326.564,9.6906307824; 1327.07,9.7112095664;
            1327.564,9.7276725936; 1328.064,9.7441356208; 1328.564,9.740019864;
            1329.062,9.7729459184; 1329.565,9.7564828912; 1330.063,9.8141034864;
            1330.563,9.781177432; 1331.063,9.7976404592; 1331.566,9.7770616752;
            1332.063,9.760598648; 1332.561,9.781177432; 1333.062,9.8264507568;
            1333.563,9.8346822704; 1334.064,9.8141034864; 1334.564,9.7688301616;
            1335.063,9.7852931888; 1335.564,9.7852931888; 1336.063,9.7935247024;
            1336.564,9.8141034864; 1337.063,9.7976404592; 1337.564,9.8305665136;
            1338.064,9.801756216; 1338.564,9.7770616752; 1339.063,9.7276725936;
            1339.563,9.6906307824; 1340.064,9.7235568368; 1340.563,9.6947465392;
            1341.064,9.7235568368; 1341.563,9.7112095664; 1342.064,9.7153253232;
            1342.562,9.6906307824; 1343.064,9.7523671344; 1343.563,9.7852931888;
            1344.064,9.801756216; 1344.563,9.7564828912; 1345.064,9.8305665136;
            1345.564,9.760598648; 1346.063,9.8182192432; 1346.564,9.8099877296;
            1347.062,9.7935247024; 1347.565,9.7235568368; 1348.064,9.7482513776;
            1348.564,9.7852931888; 1349.061,9.7935247024; 1349.566,9.7770616752;
            1350.064,9.7647144048; 1350.566,9.760598648; 1351.064,9.7647144048;
            1351.563,9.7482513776; 1352.064,9.6906307824; 1352.564,9.698862296;
            1353.064,9.6659362416; 1353.565,9.6494732144; 1354.062,9.657704728;
            1354.564,9.6947465392; 1355.064,9.698862296; 1355.564,9.6700519984;
            1356.064,9.6947465392; 1356.564,9.698862296; 1357.064,9.6700519984;
            1357.564,9.7070938096; 1358.064,9.740019864; 1358.565,9.6865150256;
            1359.065,9.7359041072; 1359.565,9.7564828912; 1360.065,9.7523671344;
            1360.565,9.7235568368; 1361.064,9.7770616752; 1361.564,9.7482513776;
            1362.063,9.71944108; 1362.564,9.678283512; 1363.065,9.698862296;
            1363.561,9.7029780528; 1364.064,9.6947465392; 1364.563,9.6947465392;
            1365.063,9.7276725936; 1365.564,9.6947465392; 1366.065,9.6947465392;
            1366.564,9.71944108; 1367.064,9.7482513776; 1367.563,9.6865150256;
            1368.065,9.7276725936; 1368.562,9.6494732144; 1369.065,9.6453574576;
            1369.565,9.678283512; 1370.064,9.6823992688; 1370.564,9.7112095664;
            1371.064,9.7317883504; 1371.564,9.698862296; 1372.063,9.6947465392;
            1372.563,9.7029780528; 1373.064,9.7317883504; 1373.564,9.7564828912;
            1374.064,9.740019864; 1374.564,9.7852931888; 1375.065,9.7317883504;
            1375.564,9.7523671344; 1376.063,9.6906307824; 1376.565,9.5712738352;
            1377.064,8.9292157744; 1377.564,7.9661286832; 1378.064,7.0606621872;
            1378.564,6.3280574768; 1379.064,5.6366103344; 1379.564,5.109793464;
            1380.065,4.677639; 1380.565,4.2166742384; 1381.064,3.9738445872;
            1381.564,3.6322367728; 1382.065,3.4141016624; 1382.561,3.2453556336;
            1383.064,3.072493848; 1383.563,2.9654841712; 1384.063,2.804969656;
            1384.565,2.7103072496; 1385.065,2.6732654384; 1385.564,2.5662557616;
            1386.064,2.5004036528; 1386.565,2.4921721392; 1387.064,2.4098570032;
            1387.564,2.331657624; 1388.064,2.2822685424; 1388.564,2.2328794608;
            1389.063,2.249342488; 1389.564,2.1999534064; 1390.066,2.1546800816;
            1390.564,2.1793746224; 1391.065,2.146448568; 1391.564,2.1711431088;
            1392.064,2.146448568; 1392.563,2.1587958384; 1393.063,2.2040691632;
            1393.564,2.1999534064; 1394.064,2.2205321904; 1394.565,2.228763704;
            1395.063,2.2452267312; 1395.564,2.2987315696; 1396.065,2.2987315696;
            1396.565,2.269921272; 1397.063,2.3193103536; 1397.563,2.352236408;
            1398.063,2.4016254896; 1398.564,2.4468988144; 1399.063,2.4180885168;
            1399.567,2.4839406256; 1400.063,2.496287896; 1400.563,2.5250981936;
            1401.064,2.6032975728; 1401.564,2.5744872752; 1402.064,2.6485708976;
            1402.564,2.6321078704; 1403.064,2.6732654384; 1403.565,2.7391175472;
            1404.063,2.7391175472; 1404.565,2.7761593584; 1405.065,2.7679278448;
            1405.563,2.8132011696; 1406.064,2.8378957104; 1406.565,2.8914005488;
            1407.065,2.9037478192; 1407.564,2.8996320624; 1408.064,2.9613684144;
            1408.564,2.9449053872; 1409.064,2.969599928; 1409.561,2.9778314416;
            1410.064,3.0066417392; 1410.563,3.0395677936; 1411.065,3.0560308208;
            1411.564,3.0642623344; 1412.066,3.1589247408; 1412.561,3.1877350384;
            1413.064,3.2124295792; 1413.565,3.2823974448; 1414.062,3.3276707696;
            1414.564,3.319439256; 1415.064,3.3482495536; 1415.563,3.3852913648;
            1416.063,3.422333176; 1416.564,3.3976386352; 1417.063,3.4346804464;
            1417.563,3.4470277168; 1418.063,3.484069528; 1418.563,3.5293428528;
            1419.063,3.5416901232; 1419.564,3.5746161776; 1420.065,3.5211113392;
            1420.563,3.5293428528; 1421.065,3.5293428528; 1421.563,3.566384664;
            1422.064,3.607542232; 1422.564,3.6486998; 1423.065,3.710436152;
            1423.561,3.6322367728; 1424.065,3.6939731248; 1424.565,3.6816258544;
            1425.061,3.6939731248; 1425.565,3.6980888816; 1426.064,3.6857416112;
            1426.563,3.6733943408; 1427.064,3.6610470704; 1427.563,3.6528155568;
            1428.062,3.689857368; 1428.565,3.6445840432; 1429.063,3.6775100976;
            1429.561,3.6157737456; 1430.062,3.6528155568; 1430.565,3.6610470704;
            1431.062,3.6610470704; 1431.561,3.6157737456; 1432.063,3.6116579888;
            1432.564,3.6486998; 1433.064,3.6528155568; 1433.562,3.6857416112;
            1434.062,3.7392464496; 1434.56,3.6198895024; 1435.063,3.6240052592;
            1435.564,3.586963448; 1436.064,3.54580588; 1436.562,3.5087640688;
            1437.064,3.5211113392; 1437.564,3.5169955824; 1438.064,3.4511434736;
            1438.563,3.4346804464; 1439.063,3.4099859056; 1439.565,3.4470277168;
            1440.065,3.4511434736; 1440.564,3.3523653104; 1441.064,3.3112077424;
            1441.564,3.298860472; 1442.065,3.278281688; 1442.563,3.3359022832;
            1443.064,3.2618186608; 1443.565,3.2494713904; 1444.064,3.23712412;
            1444.564,3.2947447152; 1445.065,3.34001804; 1445.565,3.2947447152;
            1446.062,3.2453556336; 1446.563,3.2823974448; 1447.065,3.2330083632;
            1447.564,3.1301144432; 1448.065,3.1795035248; 1448.564,3.0560308208;
            1449.064,3.093072632; 1449.564,3.0148732528; 1450.063,3.0683780912;
            1450.561,3.0189890096; 1451.064,2.9654841712; 1451.565,2.9819471984;
            1452.064,2.8996320624; 1452.564,2.866706008; 1453.065,2.887284792;
            1453.563,2.8749375216; 1454.065,2.887284792; 1454.566,2.8378957104;
            1455.065,2.8708217648; 1455.562,2.8296641968; 1456.064,2.8708217648;
            1456.563,2.8132011696; 1457.064,2.8008538992; 1457.564,2.8132011696;
            1458.064,2.8090854128; 1458.564,2.804969656; 1459.064,2.7473490608;
            1459.564,2.8008538992; 1460.064,2.7679278448; 1460.562,2.7473490608;
            1461.065,2.7391175472; 1461.565,2.702075736; 1462.064,2.6979599792;
            1462.563,2.7103072496; 1463.062,2.6897284656; 1463.565,2.6897284656;
            1464.063,2.6938442224; 1464.564,2.7350017904; 1465.066,2.7473490608;
            1465.563,2.7144230064; 1466.064,2.72265452; 1466.563,2.7267702768;
            1467.063,2.743233304; 1467.564,2.6773811952; 1468.062,2.7514648176;
            1468.564,2.702075736; 1469.065,2.7308860336; 1469.561,2.6732654384;
            1470.063,2.6938442224; 1470.565,2.6568024112; 1471.065,2.6897284656;
            1471.564,2.6897284656; 1472.063,2.6526866544; 1472.565,2.6568024112;
            1473.061,2.6362236272; 1473.564,2.6074133296; 1474.062,2.6568024112;
            1474.564,2.6362236272; 1475.064,2.5868345456; 1475.564,2.660918168;
            1476.064,2.5950660592; 1476.565,2.6197606; 1477.063,2.640339384;
            1477.565,2.6197606; 1478.065,2.6074133296; 1478.565,2.537445464;
            1479.062,2.5333297072; 1479.56,2.5127509232; 1480.062,2.5456769776;
            1480.564,2.6197606; 1481.064,2.5127509232; 1481.563,2.5539084912;
            1482.065,2.5621400048; 1482.564,2.5497927344; 1483.064,2.6485708976;
            1483.563,2.5621400048; 1484.062,2.5127509232; 1484.566,2.5621400048;
            1485.064,2.51686668; 1485.565,2.4633618416; 1486.063,2.5333297072;
            1486.563,2.4674775984; 1487.062,2.5250981936; 1487.565,2.5662557616;
            1488.065,2.5456769776; 1488.564,2.578603032; 1489.064,2.5415612208;
            1489.564,2.5333297072; 1490.062,2.558024248; 1490.566,2.5456769776;
            1491.064,2.5415612208; 1491.56,2.5744872752; 1492.064,2.5909503024;
            1492.562,2.558024248; 1493.066,2.6074133296; 1493.566,2.5868345456;
            1494.063,2.6115290864; 1494.564,2.5621400048; 1495.063,2.6732654384;
            1495.565,2.6444551408; 1496.062,2.6485708976; 1496.565,2.6032975728;
            1497.062,2.6856127088; 1497.564,2.660918168; 1498.064,2.6526866544;
            1498.563,2.6691496816; 1499.061,2.6979599792; 1499.564,2.7144230064;
            1500.063,2.6732654384; 1500.565,2.7555805744; 1501.064,2.6938442224;
            1501.563,2.763812088; 1502.063,2.7761593584; 1502.561,2.804969656;
            1503.064,2.7967381424; 1503.565,2.7514648176; 1504.062,2.7885066288;
            1504.563,2.8296641968; 1505.064,2.784390872; 1505.564,2.846127224;
            1506.064,2.8090854128; 1506.564,2.8955163056; 1507.064,2.8378957104;
            1507.564,2.8543587376; 1508.064,2.8296641968; 1508.564,2.866706008;
            1509.061,2.8914005488; 1509.564,2.8790532784; 1510.063,2.887284792;
            1510.564,2.8914005488; 1511.065,2.8996320624; 1511.562,2.8708217648;
            1512.065,2.8955163056; 1512.563,2.907863576; 1513.063,2.8955163056;
            1513.563,2.9243266032; 1514.061,2.9325581168; 1514.564,2.8790532784;
            1515.064,2.9160950896; 1515.564,2.9407896304; 1516.065,3.0189890096;
            1516.564,3.03133628; 1517.065,2.990178712; 1517.566,2.907863576;
            1518.065,2.9654841712; 1518.564,2.9942944688; 1519.062,2.9778314416;
            1519.563,3.0272205232; 1520.063,2.9942944688; 1520.565,3.0395677936;
            1521.066,3.0066417392; 1521.564,3.0189890096; 1522.065,3.0642623344;
            1522.563,3.0189890096; 1523.062,3.0477993072; 1523.563,3.0477993072;
            1524.062,3.0436835504; 1524.563,3.0683780912; 1525.064,3.0848411184;
            1525.565,3.0889568752; 1526.065,3.0848411184; 1526.563,3.0766096048;
            1527.063,3.072493848; 1527.563,3.0848411184; 1528.062,3.0889568752;
            1528.562,3.051915064; 1529.06,3.1054199024; 1529.565,3.0807253616;
            1530.064,3.1218829296; 1530.564,3.1054199024; 1531.064,3.0477993072;
            1531.564,3.1424617136; 1532.064,3.1054199024; 1532.562,3.1630404976;
            1533.063,3.1054199024; 1533.565,3.1095356592; 1534.061,3.0642623344;
            1534.563,3.1218829296; 1535.064,3.0642623344; 1535.565,3.113651416;
            1536.064,3.0642623344; 1536.564,3.093072632; 1537.062,3.0766096048;
            1537.564,3.0601465776; 1538.063,3.0848411184; 1538.565,3.0971883888;
            1539.061,3.0642623344; 1539.566,3.0889568752; 1540.063,3.0148732528;
            1540.566,3.0683780912; 1541.062,3.0231047664; 1541.563,3.0560308208;
            1542.063,3.0766096048; 1542.563,3.0889568752; 1543.063,3.0642623344;
            1543.565,3.051915064; 1544.062,3.0601465776; 1544.563,3.0231047664;
            1545.062,3.0395677936; 1545.563,3.0395677936; 1546.064,3.0148732528;
            1546.564,3.0066417392; 1547.063,3.0272205232; 1547.561,3.0395677936;
            1548.061,3.0231047664; 1548.562,2.9984102256; 1549.062,3.03133628;
            1549.563,3.0025259824; 1550.062,2.9778314416; 1550.564,3.010757496;
            1551.064,2.9449053872; 1551.563,2.9737156848; 1552.063,2.9860629552;
            1552.565,2.9942944688; 1553.062,2.9243266032; 1553.56,2.9572526576;
            1554.062,2.9202108464; 1554.562,2.9202108464; 1555.062,2.8914005488;
            1555.565,2.9119793328; 1556.062,2.9160950896; 1556.561,2.8955163056;
            1557.062,2.907863576; 1557.565,2.8790532784; 1558.063,2.907863576;
            1558.563,2.8708217648; 1559.061,2.92844236; 1559.563,2.8790532784;
            1560.064,2.8955163056; 1560.564,2.8749375216; 1561.062,2.9449053872;
            1561.564,2.9202108464; 1562.064,2.9654841712; 1562.562,2.9366738736;
            1563.065,2.9407896304; 1563.562,2.907863576; 1564.064,2.949021144;
            1564.564,2.9037478192; 1565.065,2.9325581168; 1565.563,2.92844236;
            1566.062,2.949021144; 1566.564,2.92844236; 1567.062,2.92844236;
            1567.564,2.9243266032; 1568.063,2.8955163056; 1568.561,2.9531369008;
            1569.065,2.907863576; 1569.563,2.949021144; 1570.064,2.8955163056;
            1570.563,2.907863576; 1571.063,2.907863576; 1571.563,2.92844236;
            1572.061,2.9243266032; 1572.564,2.9243266032; 1573.065,2.9160950896;
            1573.564,2.969599928; 1574.062,2.9119793328; 1574.563,2.9449053872;
            1575.061,2.9119793328; 1575.561,2.907863576; 1576.062,2.92844236;
            1576.563,2.9202108464; 1577.064,2.9613684144; 1577.564,2.8996320624;
            1578.064,2.9778314416; 1578.564,2.92844236; 1579.062,3.010757496;
            1579.563,2.9613684144; 1580.064,2.9325581168; 1580.564,3.0148732528;
            1581.064,3.0231047664; 1581.564,3.0066417392; 1582.062,2.9407896304;
            1582.564,2.9654841712; 1583.063,2.9737156848; 1583.562,2.9325581168;
            1584.064,2.9737156848; 1584.564,2.990178712; 1585.065,3.0025259824;
            1585.563,2.9407896304; 1586.064,3.0642623344; 1586.564,3.0025259824;
            1587.065,2.9572526576; 1587.564,3.0395677936; 1588.063,2.9654841712;
            1588.564,2.9737156848; 1589.063,2.9243266032; 1589.564,2.9243266032;
            1590.063,2.92844236; 1590.565,2.8996320624; 1591.065,2.9243266032;
            1591.566,2.9037478192; 1592.065,2.9160950896; 1592.563,2.9366738736;
            1593.063,2.9407896304; 1593.565,2.9613684144; 1594.062,2.9407896304;
            1594.566,2.9737156848; 1595.063,2.9572526576; 1595.563,3.0066417392;
            1596.065,2.9613684144; 1596.563,3.0025259824; 1597.061,2.9572526576;
            1597.565,2.990178712; 1598.064,3.0231047664; 1598.566,2.9819471984;
            1599.061,2.9531369008; 1599.564,2.9819471984; 1600.064,2.9984102256;
            1600.564,3.03133628; 1601.065,2.9654841712; 1601.564,2.990178712;
            1602.065,2.9407896304; 1602.564,2.9654841712; 1603.063,2.9407896304;
            1603.564,2.9037478192; 1604.062,2.9531369008; 1604.564,2.9449053872;
            1605.065,2.9243266032; 1605.564,2.8955163056; 1606.066,2.9160950896;
            1606.566,2.8749375216; 1607.064,2.990178712; 1607.565,2.9860629552;
            1608.065,2.9613684144; 1608.562,2.969599928; 1609.065,2.9572526576;
            1609.563,2.949021144; 1610.063,2.9984102256; 1610.564,3.0025259824;
            1611.065,2.9737156848; 1611.565,2.9942944688; 1612.063,3.0354520368;
            1612.565,2.9819471984; 1613.061,3.0560308208; 1613.565,2.969599928;
            1614.064,3.0066417392; 1614.564,2.9572526576; 1615.064,2.9531369008;
            1615.564,3.0066417392; 1616.063,2.9654841712; 1616.563,2.9778314416;
            1617.061,3.0148732528; 1617.563,2.990178712; 1618.063,3.0148732528;
            1618.562,2.9984102256; 1619.063,2.990178712; 1619.565,2.9984102256;
            1620.065,2.990178712; 1620.565,2.9737156848; 1621.061,2.9942944688;
            1621.562,3.051915064; 1622.065,3.0189890096; 1622.563,3.0601465776;
            1623.062,3.0848411184; 1623.564,3.051915064; 1624.064,3.0971883888;
            1624.561,3.0272205232; 1625.063,3.0601465776; 1625.564,3.0231047664;
            1626.065,3.0354520368; 1626.564,3.051915064; 1627.062,3.0436835504;
            1627.564,3.051915064; 1628.062,3.051915064; 1628.565,3.0971883888;
            1629.064,3.1259986864; 1629.565,3.1177671728; 1630.063,3.0971883888;
            1630.565,3.0807253616; 1631.061,3.0848411184; 1631.566,3.1095356592;
            1632.065,3.1013041456; 1632.564,3.1054199024; 1633.064,3.1095356592;
            1633.564,3.113651416; 1634.064,3.0354520368; 1634.563,3.051915064;
            1635.064,3.0436835504; 1635.565,3.0066417392; 1636.064,3.0436835504;
            1636.562,3.0272205232; 1637.065,2.9942944688; 1637.565,3.0148732528;
            1638.061,2.9531369008; 1638.565,2.9984102256; 1639.065,2.9778314416;
            1639.564,2.9202108464; 1640.066,2.9984102256; 1640.565,2.9407896304;
            1641.064,2.9654841712; 1641.565,2.9942944688; 1642.064,2.9778314416;
            1642.564,3.0272205232; 1643.062,2.990178712; 1643.567,2.9942944688;
            1644.064,2.9860629552; 1644.564,2.9778314416; 1645.065,2.9984102256;
            1645.564,3.0025259824; 1646.065,2.990178712; 1646.565,3.0148732528;
            1647.064,3.0231047664; 1647.563,3.0066417392; 1648.065,2.9613684144;
            1648.565,2.9613684144; 1649.064,2.9654841712; 1649.563,2.9984102256;
            1650.063,2.9572526576; 1650.565,3.0766096048; 1651.065,3.0231047664;
            1651.564,2.9860629552; 1652.066,2.9778314416; 1652.565,2.9860629552;
            1653.064,2.9778314416; 1653.565,2.9654841712; 1654.061,3.0436835504;
            1654.561,3.0560308208; 1655.062,3.0889568752; 1655.561,3.1054199024;
            1656.061,3.113651416; 1656.563,3.1095356592; 1657.062,3.1383459568;
            1657.564,3.1177671728; 1658.065,3.113651416; 1658.566,3.0848411184;
            1659.065,3.0971883888; 1659.562,3.0272205232; 1660.062,3.0560308208;
            1660.563,3.0395677936; 1661.061,3.010757496; 1661.564,3.0231047664;
            1662.064,3.0436835504; 1662.566,3.0477993072; 1663.063,3.072493848;
            1663.563,3.0848411184; 1664.064,3.0148732528; 1664.561,3.0477993072;
            1665.065,3.0148732528; 1665.564,3.010757496; 1666.064,3.0231047664;
            1666.563,2.9984102256; 1667.065,3.0272205232; 1667.565,3.0477993072;
            1668.065,3.0354520368; 1668.562,3.0477993072; 1669.062,3.010757496;
            1669.563,3.0683780912; 1670.066,3.03133628; 1670.564,2.9942944688;
            1671.063,3.1013041456; 1671.565,3.051915064; 1672.064,2.9984102256;
            1672.565,3.0477993072; 1673.063,3.072493848; 1673.561,3.0601465776;
            1674.063,3.1054199024; 1674.563,3.072493848; 1675.063,3.03133628;
            1675.564,3.0148732528; 1676.065,3.0025259824; 1676.565,3.03133628;
            1677.063,3.0436835504; 1677.563,3.0971883888; 1678.064,3.1013041456;
            1678.564,3.0889568752; 1679.066,3.0766096048; 1679.563,3.0683780912;
            1680.064,3.0436835504; 1680.56,3.1218829296; 1681.063,3.1013041456;
            1681.561,3.0436835504; 1682.062,3.0683780912; 1682.565,3.0971883888;
            1683.062,3.1177671728; 1683.564,3.093072632; 1684.065,3.1054199024;
            1684.564,3.0642623344; 1685.065,3.03133628; 1685.565,3.0148732528;
            1686.065,3.051915064; 1686.563,2.9942944688; 1687.065,3.0025259824;
            1687.564,2.9613684144; 1688.064,2.9613684144; 1688.564,2.969599928;
            1689.065,2.9366738736; 1689.565,2.9860629552; 1690.064,2.9160950896;
            1690.564,2.92844236; 1691.065,2.969599928; 1691.564,2.9572526576;
            1692.067,2.9366738736; 1692.565,2.9243266032; 1693.062,2.9737156848;
            1693.565,2.9860629552; 1694.06,2.9366738736; 1694.565,2.9572526576;
            1695.065,2.9119793328; 1695.562,2.9737156848; 1696.064,2.9613684144;
            1696.566,2.969599928; 1697.064,2.9778314416; 1697.564,2.9572526576;
            1698.063,2.9984102256; 1698.562,2.9737156848; 1699.064,3.010757496;
            1699.565,2.9572526576; 1700.066,3.0025259824; 1700.562,3.03133628;
            1701.063,2.9860629552; 1701.564,3.0231047664; 1702.064,2.9984102256;
            1702.561,3.03133628; 1703.066,3.0436835504; 1703.565,3.0395677936;
            1704.065,3.093072632; 1704.564,3.0601465776; 1705.063,3.1095356592;
            1705.564,3.0889568752; 1706.062,3.1301144432; 1706.563,3.1877350384;
            1707.063,3.2288926064; 1707.565,3.1465774704; 1708.065,3.1301144432;
            1708.565,3.1259986864; 1709.065,3.1589247408; 1709.563,3.1054199024;
            1710.061,3.0477993072; 1710.564,3.0848411184; 1711.064,3.1218829296;
            1711.563,3.1259986864; 1712.063,3.0601465776; 1712.564,3.0971883888;
            1713.063,3.093072632; 1713.564,3.0807253616; 1714.064,3.1177671728;
            1714.565,3.1095356592; 1715.064,3.0560308208; 1715.566,3.113651416;
            1716.066,3.0683780912; 1716.564,3.0272205232; 1717.061,3.0354520368;
            1717.565,3.0354520368; 1718.062,3.0560308208; 1718.563,3.0436835504;
            1719.064,3.051915064; 1719.562,3.0477993072; 1720.065,3.0766096048;
            1720.565,3.051915064; 1721.065,3.072493848; 1721.564,3.0889568752;
            1722.065,3.0642623344; 1722.564,3.113651416; 1723.065,3.0560308208;
            1723.565,3.0601465776; 1724.065,3.0683780912; 1724.561,3.051915064;
            1725.064,3.072493848; 1725.564,3.0807253616; 1726.065,3.0807253616;
            1726.565,3.0848411184; 1727.064,3.0395677936; 1727.563,3.072493848;
            1728.064,3.1013041456; 1728.563,3.0683780912; 1729.065,3.0601465776;
            1729.564,3.0889568752; 1730.064,3.113651416; 1730.564,3.0889568752;
            1731.064,3.0807253616; 1731.564,3.1013041456; 1732.066,3.0807253616;
            1732.563,3.1177671728; 1733.064,3.0683780912; 1733.564,3.0560308208;
            1734.062,3.0971883888; 1734.562,3.113651416; 1735.063,3.0889568752;
            1735.563,3.1013041456; 1736.063,3.0766096048; 1736.565,3.1177671728;
            1737.064,3.0889568752; 1737.563,3.0683780912; 1738.063,3.0807253616;
            1738.565,3.0601465776; 1739.064,3.0807253616; 1739.562,3.072493848;
            1740.065,3.0889568752; 1740.561,3.093072632; 1741.066,3.0189890096;
            1741.564,3.1054199024; 1742.064,3.1506932272; 1742.563,3.1589247408;
            1743.062,3.1259986864; 1743.564,3.0601465776; 1744.063,3.0560308208;
            1744.562,3.093072632; 1745.063,3.113651416; 1745.564,3.0560308208;
            1746.065,3.0560308208; 1746.561,3.0807253616; 1747.062,3.1342302;
            1747.563,3.0683780912; 1748.065,3.1095356592; 1748.564,3.0766096048;
            1749.063,3.0807253616; 1749.562,3.1177671728; 1750.064,3.113651416;
            1750.564,3.0231047664; 1751.065,3.0848411184; 1751.566,3.0477993072;
            1752.064,3.072493848; 1752.565,3.0642623344; 1753.064,3.0683780912;
            1753.565,3.0848411184; 1754.066,3.0477993072; 1754.562,3.0807253616;
            1755.064,3.0436835504; 1755.563,3.0436835504; 1756.063,3.0354520368;
            1756.565,3.1177671728; 1757.065,3.0436835504; 1757.565,3.0889568752;
            1758.064,3.010757496; 1758.564,3.0395677936; 1759.063,3.0354520368;
            1759.563,3.0066417392; 1760.066,3.0354520368; 1760.563,3.1177671728;
            1761.065,3.0272205232; 1761.566,3.0848411184; 1762.063,3.0395677936;
            1762.564,3.0766096048; 1763.064,3.0231047664; 1763.563,3.072493848;
            1764.065,3.0642623344; 1764.562,3.0436835504; 1765.063,3.03133628;
            1765.565,3.1301144432; 1766.064,3.0395677936; 1766.563,3.0560308208;
            1767.065,3.0354520368; 1767.564,3.0231047664; 1768.065,3.051915064;
            1768.564,3.0436835504; 1769.064,3.072493848; 1769.562,3.1054199024;
            1770.065,3.093072632; 1770.562,3.0807253616; 1771.065,3.1013041456;
            1771.563,3.1177671728; 1772.064,3.1671562544; 1772.563,3.1301144432;
            1773.063,3.2124295792; 1773.564,3.1836192816; 1774.064,3.1712720112;
            1774.561,3.2083138224; 1775.064,3.1630404976; 1775.56,3.1795035248;
            1776.065,3.1301144432; 1776.564,3.1506932272; 1777.065,3.1095356592;
            1777.564,3.1177671728; 1778.066,3.1177671728; 1778.564,3.0766096048;
            1779.064,3.072493848; 1779.563,3.051915064; 1780.063,3.0766096048;
            1780.563,3.0848411184; 1781.064,3.0889568752; 1781.564,3.0642623344;
            1782.065,3.072493848; 1782.563,3.0807253616; 1783.063,3.0560308208;
            1783.563,3.072493848; 1784.066,3.093072632; 1784.562,3.0189890096;
            1785.066,3.051915064; 1785.564,3.0066417392; 1786.064,3.0066417392;
            1786.563,2.9778314416; 1787.063,3.0148732528; 1787.564,3.0436835504;
            1788.065,3.0272205232; 1788.564,3.072493848; 1789.064,3.051915064;
            1789.564,3.051915064; 1790.065,3.1054199024; 1790.564,3.051915064;
            1791.064,3.0642623344; 1791.564,3.0683780912; 1792.062,3.0066417392;
            1792.564,3.1506932272; 1793.063,3.0601465776; 1793.564,3.0683780912;
            1794.063,3.0560308208; 1794.562,3.0025259824; 1795.064,2.9984102256;
            1795.563,3.0848411184; 1796.064,3.03133628; 1796.565,3.0477993072;
            1797.064,3.0189890096; 1797.564,3.03133628; 1798.064,3.0848411184;
            1798.564,3.03133628; 1799.065,3.03133628; 1799.566,3.010757496;
            1800.062,2.9778314416; 1800.564,3.0601465776; 1801.063,3.0354520368;
            1801.566,3.0477993072; 1802.065,3.0189890096; 1802.565,3.0354520368;
            1803.065,2.9942944688; 1803.566,3.0272205232; 1804.063,3.072493848;
            1804.564,3.0477993072; 1805.065,3.0436835504; 1805.566,3.051915064;
            1806.065,3.0642623344; 1806.564,3.0395677936; 1807.064,3.051915064;
            1807.562,3.0272205232; 1808.063,3.010757496; 1808.563,3.0477993072;
            1809.065,3.0148732528; 1809.566,3.0848411184; 1810.065,3.0889568752;
            1810.564,3.0560308208; 1811.063,3.0766096048; 1811.565,3.0601465776;
            1812.066,3.093072632; 1812.565,3.1054199024; 1813.065,3.1013041456;
            1813.565,3.1013041456; 1814.063,3.1177671728; 1814.566,3.1013041456;
            1815.065,3.051915064; 1815.564,3.0601465776; 1816.066,3.0848411184;
            1816.565,3.093072632; 1817.065,3.1259986864; 1817.565,3.154808984;
            1818.065,3.1054199024; 1818.564,3.051915064; 1819.064,3.0848411184;
            1819.564,3.1095356592; 1820.066,3.1465774704; 1820.563,3.1259986864;
            1821.065,3.1218829296; 1821.565,3.1301144432; 1822.064,3.113651416;
            1822.565,3.1836192816; 1823.064,3.1671562544; 1823.564,3.1342302;
            1824.064,3.0971883888; 1824.565,3.093072632; 1825.064,3.0807253616;
            1825.565,3.1054199024; 1826.065,3.1259986864; 1826.565,3.1177671728;
            1827.065,3.0683780912; 1827.566,3.093072632; 1828.065,3.0766096048;
            1828.566,2.990178712; 1829.064,3.0148732528; 1829.565,3.0766096048;
            1830.065,3.0683780912; 1830.564,3.1301144432; 1831.065,3.1301144432;
            1831.565,3.093072632; 1832.064,3.1836192816; 1832.563,3.1177671728;
            1833.064,3.1342302; 1833.564,3.1177671728; 1834.062,3.1177671728;
            1834.562,3.1342302; 1835.065,3.0971883888; 1835.563,3.113651416;
            1836.065,3.1054199024; 1836.565,3.0971883888; 1837.064,3.0807253616;
            1837.564,3.0848411184; 1838.064,3.0683780912; 1838.564,3.0889568752;
            1839.064,3.113651416; 1839.565,3.0848411184; 1840.067,3.113651416;
            1840.565,3.1259986864; 1841.066,3.1506932272; 1841.564,3.1218829296;
            1842.065,3.1383459568; 1842.566,3.1465774704; 1843.064,3.1424617136;
            1843.563,3.1630404976; 1844.066,3.0848411184; 1844.566,3.1424617136;
            1845.065,3.1671562544; 1845.563,3.175387768; 1846.065,3.216545336;
            1846.565,3.2494713904; 1847.064,3.2288926064; 1847.566,3.2083138224;
            1848.066,3.216545336; 1848.566,3.2041980656; 1849.066,3.1877350384;
            1849.566,3.1836192816; 1850.066,3.1877350384; 1850.565,3.154808984;
            1851.065,3.1218829296; 1851.565,3.0971883888; 1852.064,3.1342302;
            1852.564,3.0807253616; 1853.065,3.0766096048; 1853.565,3.093072632;
            1854.065,3.0848411184; 1854.565,3.093072632; 1855.065,3.0848411184;
            1855.565,3.1177671728; 1856.061,3.1013041456; 1856.563,3.1342302;
            1857.064,3.1013041456; 1857.565,3.1054199024; 1858.065,3.1342302;
            1858.565,3.093072632; 1859.066,3.1259986864; 1859.564,3.0807253616;
            1860.064,3.0971883888; 1860.565,3.0642623344; 1861.064,3.0683780912;
            1861.565,3.1054199024; 1862.064,3.072493848; 1862.565,3.0642623344;
            1863.062,3.1218829296; 1863.565,3.113651416; 1864.061,3.0601465776;
            1864.563,3.113651416; 1865.063,3.0971883888; 1865.563,3.0683780912;
            1866.062,3.0807253616; 1866.566,3.1342302; 1867.065,3.0189890096;
            1867.565,3.0066417392; 1868.065,3.0395677936; 1868.564,3.1013041456;
            1869.064,3.0807253616; 1869.564,3.1013041456; 1870.066,3.0560308208;
            1870.566,2.9942944688; 1871.066,3.1013041456; 1871.563,3.1054199024;
            1872.063,3.0231047664; 1872.566,3.0807253616; 1873.065,3.113651416;
            1873.565,3.0889568752; 1874.062,3.0477993072; 1874.564,3.0272205232;
            1875.065,3.051915064; 1875.565,3.0642623344; 1876.066,3.072493848;
            1876.566,3.093072632; 1877.063,3.0395677936; 1877.563,3.0889568752;
            1878.064,3.0642623344; 1878.564,3.0395677936; 1879.063,3.0642623344;
            1879.562,3.0354520368; 1880.065,3.0766096048; 1880.563,3.0189890096;
            1881.062,3.0848411184; 1881.564,3.0971883888; 1882.064,3.0642623344;
            1882.565,3.0354520368; 1883.064,3.0848411184; 1883.565,3.0601465776;
            1884.065,3.0642623344; 1884.565,3.0807253616; 1885.064,3.0889568752;
            1885.562,3.1095356592; 1886.063,3.0683780912; 1886.565,3.0889568752;
            1887.066,3.0971883888; 1887.564,3.0642623344; 1888.064,3.0766096048;
            1888.565,3.0231047664; 1889.065,3.0601465776; 1889.564,3.1054199024;
            1890.063,3.051915064; 1890.564,3.0642623344; 1891.064,3.0642623344;
            1891.565,3.0477993072; 1892.064,3.0683780912; 1892.564,3.051915064;
            1893.065,3.1054199024; 1893.563,3.0066417392; 1894.063,3.0683780912;
            1894.562,3.0560308208; 1895.064,3.0560308208; 1895.565,3.03133628;
            1896.065,3.0971883888; 1896.565,3.0436835504; 1897.066,3.0601465776;
            1897.566,3.0395677936; 1898.063,3.051915064; 1898.563,3.0807253616;
            1899.064,3.0642623344; 1899.564,3.0889568752; 1900.065,3.072493848;
            1900.564,3.093072632; 1901.065,3.0807253616; 1901.565,3.093072632;
            1902.065,3.093072632; 1902.563,3.0971883888; 1903.063,3.0971883888;
            1903.565,3.1342302; 1904.061,3.0683780912; 1904.564,3.0354520368;
            1905.065,3.1013041456; 1905.565,3.1259986864; 1906.063,3.072493848;
            1906.565,3.072493848; 1907.066,3.093072632; 1907.564,3.0848411184;
            1908.066,3.1177671728; 1908.565,3.0807253616; 1909.065,3.0971883888;
            1909.565,3.1259986864; 1910.065,3.1259986864; 1910.566,3.1054199024;
            1911.065,3.1630404976; 1911.565,3.113651416; 1912.065,3.1506932272;
            1912.565,3.1177671728; 1913.064,3.1630404976; 1913.564,3.154808984;
            1914.064,3.1506932272; 1914.564,3.1218829296; 1915.066,3.1589247408;
            1915.562,3.1836192816; 1916.063,3.1424617136; 1916.565,3.1630404976;
            1917.064,3.154808984; 1917.565,3.2083138224; 1918.065,3.1630404976;
            1918.564,3.1712720112; 1919.063,3.1877350384; 1919.564,3.1795035248;
            1920.064,3.1465774704; 1920.566,3.2124295792; 1921.064,3.2124295792;
            1921.565,3.216545336; 1922.063,3.1712720112; 1922.564,3.0889568752;
            1923.065,3.1301144432; 1923.565,3.1177671728; 1924.062,3.1054199024;
            1924.564,3.175387768; 1925.06,3.1424617136; 1925.565,3.1013041456;
            1926.064,3.1630404976; 1926.564,3.113651416; 1927.065,3.1506932272;
            1927.565,3.1177671728; 1928.062,3.1589247408; 1928.564,3.1342302;
            1929.063,3.1177671728; 1929.565,3.1383459568; 1930.064,3.1465774704;
            1930.565,3.1506932272; 1931.064,3.113651416; 1931.563,3.0889568752;
            1932.063,3.1465774704; 1932.565,3.0848411184; 1933.065,3.1259986864;
            1933.562,3.0848411184; 1934.065,3.0560308208; 1934.563,3.072493848;
            1935.062,3.0766096048; 1935.565,3.0560308208; 1936.062,3.0148732528;
            1936.564,3.0066417392; 1937.065,3.0272205232; 1937.565,3.051915064;
            1938.065,3.0272205232; 1938.567,3.03133628; 1939.065,3.051915064;
            1939.563,3.0766096048; 1940.065,3.0807253616; 1940.566,3.0601465776;
            1941.063,3.1259986864; 1941.564,3.0683780912; 1942.066,3.1301144432;
            1942.565,3.1095356592; 1943.066,3.1013041456; 1943.565,3.072493848;
            1944.065,3.1095356592; 1944.562,3.0683780912; 1945.065,3.1095356592;
            1945.564,3.0889568752; 1946.062,3.1095356592; 1946.565,3.1630404976;
            1947.062,3.0971883888; 1947.563,3.1383459568; 1948.065,3.1424617136;
            1948.564,3.1589247408; 1949.061,3.1054199024; 1949.565,3.2041980656;
            1950.062,3.1836192816; 1950.563,3.278281688; 1951.065,3.2618186608;
            1951.565,3.216545336; 1952.066,3.23712412; 1952.563,3.1836192816;
            1953.065,3.1795035248; 1953.565,3.1918507952; 1954.065,3.1877350384;
            1954.564,3.154808984; 1955.065,3.1301144432; 1955.566,3.1506932272;
            1956.065,3.0766096048; 1956.565,3.1013041456; 1957.065,3.0971883888;
            1957.564,3.0971883888; 1958.064,3.1589247408; 1958.563,3.1259986864;
            1959.063,3.1095356592; 1959.565,3.1342302; 1960.065,3.1506932272;
            1960.564,3.1177671728; 1961.063,3.1671562544; 1961.565,3.1259986864;
            1962.063,3.1342302; 1962.562,3.1589247408; 1963.064,3.1465774704;
            1963.564,3.2000823088; 1964.065,3.1424617136; 1964.564,3.1383459568;
            1965.062,3.1301144432; 1965.562,3.1506932272; 1966.064,3.1465774704;
            1966.564,3.1013041456; 1967.065,3.0889568752; 1967.564,3.0971883888;
            1968.065,3.0848411184; 1968.566,3.0766096048; 1969.065,3.1506932272;
            1969.563,3.1712720112; 1970.064,3.2000823088; 1970.562,3.1177671728;
            1971.065,3.1465774704; 1971.564,3.1836192816; 1972.063,3.175387768;
            1972.565,3.1465774704; 1973.061,3.1877350384; 1973.564,3.2124295792;
            1974.065,3.2206610928; 1974.566,3.195966552; 1975.064,3.1589247408;
            1975.565,3.2330083632; 1976.064,3.2083138224; 1976.564,3.175387768;
            1977.065,3.1054199024; 1977.564,3.154808984; 1978.064,3.1177671728;
            1978.564,3.1465774704; 1979.066,3.0971883888; 1979.564,3.072493848;
            1980.066,3.093072632; 1980.565,3.1301144432; 1981.065,3.1013041456;
            1981.562,3.1218829296; 1982.065,3.0601465776; 1982.565,3.113651416;
            1983.065,3.1054199024; 1983.564,3.072493848; 1984.066,3.0848411184;
            1984.565,3.0560308208; 1985.065,3.1095356592; 1985.565,3.03133628;
            1986.065,3.1013041456; 1986.566,3.0807253616; 1987.066,3.1095356592;
            1987.565,3.1054199024; 1988.066,3.0889568752; 1988.565,3.0766096048;
            1989.065,3.0807253616; 1989.565,3.0889568752; 1990.065,3.072493848;
            1990.566,3.1177671728; 1991.065,3.154808984; 1991.565,3.2206610928;
            1992.063,3.2618186608; 1992.565,3.2618186608; 1993.066,3.2330083632;
            1993.567,3.2000823088; 1994.064,3.1877350384; 1994.562,3.1918507952;
            1995.065,3.1218829296; 1995.566,3.1383459568; 1996.064,3.093072632;
            1996.564,3.1383459568; 1997.065,3.0560308208; 1997.566,3.1465774704;
            1998.064,3.175387768; 1998.562,3.1795035248; 1999.064,3.2288926064;
            1999.565,3.1918507952; 2000.063,3.1259986864; 2000.566,3.1383459568;
            2001.064,3.1177671728; 2001.563,3.1218829296; 2002.065,3.1301144432;
            2002.565,3.1383459568; 2003.065,3.0971883888; 2003.564,3.1177671728;
            2004.066,3.113651416; 2004.562,3.1671562544; 2005.063,3.1342302;
            2005.564,3.1671562544; 2006.066,3.1589247408; 2006.566,3.175387768;
            2007.064,3.1712720112; 2007.566,3.2206610928; 2008.065,3.2247768496;
            2008.563,3.1877350384; 2009.066,3.1259986864; 2009.565,3.1795035248;
            2010.062,3.2288926064; 2010.563,3.2206610928; 2011.063,3.2041980656;
            2011.564,3.1095356592; 2012.067,3.1095356592; 2012.565,3.1095356592;
            2013.062,3.1383459568; 2013.567,3.1218829296; 2014.065,3.0971883888;
            2014.566,3.0807253616; 2015.063,3.0642623344; 2015.566,3.0395677936;
            2016.064,3.0848411184; 2016.564,3.113651416; 2017.067,3.0560308208;
            2017.565,3.1218829296; 2018.065,3.1095356592; 2018.565,3.072493848;
            2019.066,3.1342302; 2019.566,3.1218829296; 2020.061,3.1383459568;
            2020.565,3.1795035248; 2021.064,3.175387768; 2021.566,3.1301144432;
            2022.065,3.0807253616; 2022.566,3.1177671728; 2023.065,3.093072632;
            2023.562,3.2041980656; 2024.065,3.1218829296; 2024.563,3.1424617136;
            2025.062,3.1589247408; 2025.563,3.1671562544; 2026.064,3.1712720112;
            2026.565,3.2453556336; 2027.066,3.2700501744; 2027.565,3.3112077424;
            2028.066,3.2865132016; 2028.564,3.2659344176; 2029.066,3.1424617136;
            2029.564,3.154808984; 2030.061,3.2041980656; 2030.566,3.175387768;
            2031.065,3.1383459568; 2031.566,3.1218829296; 2032.063,3.1712720112;
            2032.565,3.0601465776; 2033.066,3.1465774704; 2033.565,3.1177671728;
            2034.067,3.113651416; 2034.567,3.1095356592; 2035.062,3.1383459568;
            2035.564,3.1630404976; 2036.065,3.1506932272; 2036.565,3.2083138224;
            2037.065,3.1671562544; 2037.566,3.1301144432; 2038.065,3.1095356592;
            2038.565,3.1712720112; 2039.064,3.0560308208; 2039.565,3.1218829296;
            2040.066,3.0971883888; 2040.565,3.1301144432; 2041.066,3.1671562544;
            2041.564,3.175387768; 2042.066,3.1383459568; 2042.565,3.1301144432;
            2043.065,3.113651416; 2043.565,3.1918507952; 2044.066,3.1877350384;
            2044.566,3.2124295792; 2045.065,3.1712720112; 2045.566,3.1671562544;
            2046.065,3.1918507952; 2046.561,3.1383459568; 2047.066,3.1630404976;
            2047.565,3.1424617136; 2048.065,3.1465774704; 2048.565,3.1218829296;
            2049.066,3.1259986864; 2049.566,3.1383459568; 2050.066,3.0766096048;
            2050.565,3.072493848; 2051.064,3.1054199024; 2051.562,3.1095356592;
            2052.062,3.0766096048; 2052.564,3.0642623344; 2053.066,3.0354520368;
            2053.566,3.0889568752; 2054.066,3.093072632; 2054.566,3.0807253616;
            2055.065,3.0642623344; 2055.562,3.0889568752; 2056.065,3.0766096048;
            2056.566,3.113651416; 2057.065,3.0807253616; 2057.562,3.0848411184;
            2058.065,3.0971883888; 2058.565,3.1054199024; 2059.066,3.0889568752;
            2059.564,3.0889568752; 2060.063,3.0395677936; 2060.563,3.03133628;
            2061.065,3.051915064; 2061.566,3.0477993072; 2062.065,3.1013041456;
            2062.565,3.1218829296; 2063.066,3.0848411184; 2063.563,3.113651416;
            2064.067,3.1383459568; 2064.565,3.1013041456; 2065.066,3.1589247408;
            2065.565,3.1795035248; 2066.065,3.2041980656; 2066.565,3.2412398768;
            2067.066,3.2288926064; 2067.564,3.2412398768; 2068.063,3.216545336;
            2068.565,3.1877350384; 2069.065,3.2083138224; 2069.562,3.1836192816;
            2070.062,3.154808984; 2070.575,3.1671562544; 2071.07,3.1630404976;
            2071.565,3.1836192816; 2072.064,3.1054199024; 2072.565,3.195966552;
            2073.065,3.154808984; 2073.563,3.1671562544; 2074.066,3.1671562544;
            2074.566,3.1836192816; 2075.064,3.216545336; 2075.565,3.1918507952;
            2076.063,3.1836192816; 2076.564,3.154808984; 2077.065,3.175387768;
            2077.566,3.1712720112; 2078.066,3.1671562544; 2078.562,3.1795035248;
            2079.065,3.1918507952; 2079.563,3.175387768; 2080.064,3.1671562544;
            2080.566,3.1301144432; 2081.063,3.1013041456; 2081.563,3.1054199024;
            2082.065,3.0560308208; 2082.564,3.0807253616; 2083.065,3.0971883888;
            2083.564,3.1506932272; 2084.066,3.1877350384; 2084.564,3.154808984;
            2085.066,3.1918507952; 2085.564,3.2124295792; 2086.065,3.175387768;
            2086.562,3.216545336; 2087.062,3.154808984; 2087.564,3.1095356592;
            2088.065,3.175387768; 2088.565,3.1836192816; 2089.065,3.2124295792;
            2089.565,3.2206610928; 2090.065,3.1671562544; 2090.564,3.2000823088;
            2091.063,3.175387768; 2091.565,3.2124295792; 2092.065,3.2412398768;
            2092.566,3.1630404976; 2093.065,3.2083138224; 2093.566,3.1342302;
            2094.064,3.1630404976; 2094.565,3.1424617136; 2095.065,3.1424617136;
            2095.568,3.1259986864; 2096.065,3.1054199024; 2096.565,3.1465774704;
            2097.067,3.1383459568; 2097.565,3.093072632; 2098.065,3.072493848;
            2098.565,3.1465774704; 2099.066,3.0971883888; 2099.565,3.1095356592;
            2100.066,3.1095356592; 2100.566,3.1013041456; 2101.065,3.0642623344;
            2101.565,3.0971883888; 2102.064,3.051915064; 2102.565,3.0066417392;
            2103.065,3.0148732528; 2103.564,3.0395677936; 2104.065,3.03133628;
            2104.567,3.0642623344; 2105.064,3.1054199024; 2105.565,3.0889568752;
            2106.065,3.051915064; 2106.565,3.0477993072; 2107.065,3.1342302;
            2107.566,3.072493848; 2108.068,3.0231047664; 2108.562,3.03133628;
            2109.066,3.0683780912; 2109.564,3.1301144432; 2110.062,3.113651416;
            2110.562,3.0848411184; 2111.063,3.0848411184; 2111.562,3.0683780912;
            2112.062,3.051915064; 2112.566,3.0889568752; 2113.065,3.0477993072;
            2113.564,3.03133628; 2114.066,3.072493848; 2114.562,3.0601465776;
            2115.062,3.0766096048; 2115.565,3.1013041456; 2116.066,3.0766096048;
            2116.563,3.1506932272; 2117.065,3.0560308208; 2117.563,3.1630404976;
            2118.063,3.1259986864; 2118.562,3.0766096048; 2119.063,3.1342302;
            2119.562,3.093072632; 2120.062,3.0848411184; 2120.563,3.0807253616;
            2121.063,3.1342302; 2121.562,3.1013041456; 2122.063,3.1342302;
            2122.563,3.154808984; 2123.063,3.1424617136; 2123.565,3.1465774704;
            2124.064,3.1671562544; 2124.564,3.1589247408; 2125.064,3.1506932272;
            2125.565,3.1383459568; 2126.064,3.1630404976; 2126.564,3.1630404976;
            2127.064,3.216545336; 2127.564,3.2041980656; 2128.065,3.2412398768;
            2128.563,3.2247768496; 2129.064,3.2288926064; 2129.566,3.2247768496;
            2130.065,3.2494713904; 2130.564,3.2906289584; 2131.066,3.278281688;
            2131.565,3.2453556336; 2132.066,3.23712412; 2132.566,3.195966552;
            2133.065,3.2083138224; 2133.563,3.2206610928; 2134.063,3.2206610928;
            2134.565,3.216545336; 2135.065,3.2206610928; 2135.563,3.2535871472;
            2136.065,3.2618186608; 2136.564,3.2083138224; 2137.066,3.2288926064;
            2137.563,3.1671562544; 2138.066,3.1506932272; 2138.565,3.195966552;
            2139.064,3.257702904; 2139.563,3.1795035248; 2140.064,3.2453556336;
            2140.564,3.2535871472; 2141.064,3.2535871472; 2141.563,3.2494713904;
            2142.064,3.2741659312; 2142.562,3.3029762288; 2143.065,3.2906289584;
            2143.566,3.2823974448; 2144.062,3.2906289584; 2144.565,3.2618186608;
            2145.063,3.2741659312; 2145.563,3.2823974448; 2146.066,3.2659344176;
            2146.562,3.23712412; 2147.062,3.216545336; 2147.565,3.195966552;
            2148.065,3.2535871472; 2148.563,3.2288926064; 2149.066,3.1877350384;
            2149.565,3.2330083632; 2150.066,3.1712720112; 2150.565,3.1712720112;
            2151.066,3.1465774704; 2151.566,3.1342302; 2152.063,3.1712720112;
            2152.565,3.1424617136; 2153.066,3.1836192816; 2153.566,3.1259986864;
            2154.065,3.1877350384; 2154.562,3.1465774704; 2155.062,3.1836192816;
            2155.563,3.2000823088; 2156.064,3.1301144432; 2156.564,3.1877350384;
            2157.065,3.093072632; 2157.565,3.0807253616; 2158.065,3.0971883888;
            2158.564,3.1712720112; 2159.064,3.1712720112; 2159.565,3.175387768;
            2160.065,3.2000823088; 2160.563,3.1712720112; 2161.064,3.1712720112;
            2161.566,3.1465774704; 2162.064,3.1712720112; 2162.564,3.2041980656;
            2163.064,3.2041980656; 2163.566,3.2000823088; 2164.065,3.113651416;
            2164.563,3.1795035248; 2165.064,3.1918507952; 2165.565,3.1218829296;
            2166.065,3.2041980656; 2166.565,3.1836192816; 2167.064,3.1712720112;
            2167.565,3.1712720112; 2168.065,3.1506932272; 2168.564,3.1383459568;
            2169.066,3.0889568752; 2169.564,3.1054199024; 2170.066,3.1013041456;
            2170.565,3.1218829296; 2171.066,3.1013041456; 2171.564,3.1383459568;
            2172.066,3.1301144432; 2172.565,3.2000823088; 2173.065,3.1918507952;
            2173.565,3.216545336; 2174.066,3.216545336; 2174.564,3.1671562544;
            2175.064,3.1795035248; 2175.564,3.2000823088; 2176.065,3.1836192816;
            2176.565,3.175387768; 2177.065,3.1836192816; 2177.565,3.1671562544;
            2178.064,3.1671562544; 2178.566,3.1506932272; 2179.064,3.1795035248;
            2179.563,3.1259986864; 2180.066,3.175387768; 2180.563,3.1383459568;
            2181.065,3.1383459568; 2181.565,3.1506932272; 2182.065,3.1301144432;
            2182.563,3.0971883888; 2183.066,3.0560308208; 2183.564,3.051915064;
            2184.064,3.0477993072; 2184.562,3.0848411184; 2185.066,3.1465774704;
            2185.565,3.0807253616; 2186.065,3.1342302; 2186.566,3.1259986864;
            2187.065,3.1712720112; 2187.565,3.154808984; 2188.065,3.154808984;
            2188.565,3.1342302; 2189.064,3.1259986864; 2189.565,3.1424617136;
            2190.065,3.1259986864; 2190.564,3.1630404976; 2191.064,3.154808984;
            2191.564,3.154808984; 2192.065,3.175387768; 2192.564,3.1795035248;
            2193.066,3.1795035248; 2193.564,3.154808984; 2194.065,3.2247768496;
            2194.565,3.1671562544; 2195.065,3.1836192816; 2195.566,3.1712720112;
            2196.064,3.175387768; 2196.565,3.175387768; 2197.064,3.1465774704;
            2197.562,3.1424617136; 2198.064,3.2412398768; 2198.564,3.2124295792;
            2199.065,3.1301144432; 2199.563,3.1383459568; 2200.065,3.1671562544;
            2200.565,3.1465774704; 2201.064,3.1712720112; 2201.565,3.0889568752;
            2202.065,3.1630404976; 2202.563,3.1671562544; 2203.064,3.1383459568;
            2203.565,3.1795035248; 2204.067,3.1218829296; 2204.564,3.1589247408;
            2205.065,3.1465774704; 2205.562,3.1383459568; 2206.065,3.0889568752;
            2206.565,3.1301144432; 2207.066,3.093072632; 2207.565,3.0848411184;
            2208.065,3.1054199024; 2208.564,3.1054199024; 2209.065,3.1424617136;
            2209.566,3.1383459568; 2210.065,3.1259986864; 2210.561,3.1218829296;
            2211.065,3.1383459568; 2211.563,3.154808984; 2212.065,3.1383459568;
            2212.565,3.1836192816; 2213.066,3.2083138224; 2213.564,3.1918507952;
            2214.065,3.2041980656; 2214.565,3.1589247408; 2215.065,3.1877350384;
            2215.561,3.2124295792; 2216.064,3.1877350384; 2216.563,3.2330083632;
            2217.064,3.1671562544; 2217.563,3.1836192816; 2218.066,3.1671562544;
            2218.566,3.1877350384; 2219.066,3.154808984; 2219.565,3.1877350384;
            2220.064,3.1589247408; 2220.561,3.1506932272; 2221.066,3.1836192816;
            2221.565,3.175387768; 2222.066,3.2083138224; 2222.565,3.1589247408;
            2223.066,3.1712720112; 2223.566,3.2000823088; 2224.065,3.1836192816;
            2224.566,3.2330083632; 2225.065,3.195966552; 2225.562,3.175387768;
            2226.065,3.2206610928; 2226.565,3.216545336; 2227.067,3.2535871472;
            2227.564,3.2412398768; 2228.065,3.2659344176; 2228.565,3.2206610928;
            2229.067,3.2659344176; 2229.565,3.23712412; 2230.066,3.298860472;
            2230.562,3.3112077424; 2231.065,3.2947447152; 2231.565,3.2741659312;
            2232.065,3.1630404976; 2232.565,3.1630404976; 2233.065,3.1424617136;
            2233.567,3.1465774704; 2234.067,3.113651416; 2234.566,3.1506932272;
            2235.066,3.1054199024; 2235.562,3.0971883888; 2236.065,3.093072632;
            2236.562,3.1383459568; 2237.065,3.0971883888; 2237.563,3.1259986864;
            2238.066,3.0560308208; 2238.565,3.0766096048; 2239.066,3.1095356592;
            2239.566,3.0683780912; 2240.066,3.093072632; 2240.563,3.0560308208;
            2241.065,3.1054199024; 2241.566,3.072493848; 2242.065,3.072493848;
            2242.566,3.0766096048; 2243.066,3.0889568752; 2243.565,3.1259986864;
            2244.064,3.0848411184; 2244.566,3.1013041456; 2245.065,3.1506932272;
            2245.562,3.1795035248; 2246.065,3.1506932272; 2246.566,3.0601465776;
            2247.066,3.0231047664; 2247.564,3.051915064; 2248.066,3.0889568752;
            2248.565,3.0642623344; 2249.067,3.1383459568; 2249.565,3.051915064;
            2250.066,3.0642623344; 2250.564,3.0436835504; 2251.064,3.0354520368;
            2251.565,3.0477993072; 2252.065,3.1013041456; 2252.565,3.0807253616;
            2253.066,3.1054199024; 2253.566,3.1671562544; 2254.065,3.1383459568;
            2254.567,3.113651416; 2255.066,3.154808984; 2255.563,3.1177671728;
            2256.066,3.154808984; 2256.564,3.1630404976; 2257.065,3.1342302;
            2257.565,3.1712720112; 2258.065,3.1712720112; 2258.566,3.2412398768;
            2259.067,3.1589247408; 2259.565,3.1918507952; 2260.064,3.23712412;
            2260.561,3.216545336; 2261.065,3.1918507952; 2261.565,3.2247768496;
            2262.065,3.195966552; 2262.564,3.2000823088; 2263.065,3.216545336;
            2263.566,3.1671562544; 2264.065,3.1877350384; 2264.566,3.1918507952;
            2265.064,3.1712720112; 2265.561,3.1342302; 2266.065,3.1589247408;
            2266.567,3.1589247408; 2267.066,3.1465774704; 2267.567,3.1177671728;
            2268.064,3.175387768; 2268.566,3.1630404976; 2269.066,3.1342302;
            2269.565,3.0848411184; 2270.065,3.1177671728; 2270.562,3.0766096048;
            2271.067,3.093072632; 2271.566,3.1383459568; 2272.066,3.1795035248;
            2272.565,3.1506932272; 2273.066,3.1465774704; 2273.565,3.2041980656;
            2274.065,3.1795035248; 2274.564,3.1589247408; 2275.065,3.1465774704;
            2275.565,3.154808984; 2276.067,3.1506932272; 2276.565,3.1795035248;
            2277.066,3.1877350384; 2277.566,3.1795035248; 2278.067,3.2124295792;
            2278.565,3.175387768; 2279.064,3.1918507952; 2279.564,3.2124295792;
            2280.064,3.1342302; 2280.566,3.2000823088; 2281.065,3.1301144432;
            2281.565,3.1795035248; 2282.066,3.154808984; 2282.566,3.1342302;
            2283.067,3.1013041456; 2283.564,3.195966552; 2284.067,3.2124295792;
            2284.565,3.1671562544; 2285.064,3.1259986864; 2285.565,3.1259986864;
            2286.066,3.1712720112; 2286.567,3.1712720112; 2287.065,3.1712720112;
            2287.565,3.1465774704; 2288.067,3.2000823088; 2288.566,3.1259986864;
            2289.065,3.1342302; 2289.566,3.1054199024; 2290.067,3.175387768;
            2290.566,3.1918507952; 2291.067,3.1630404976; 2291.566,3.2083138224;
            2292.066,3.1671562544; 2292.565,3.23712412; 2293.066,3.2288926064;
            2293.565,3.2041980656; 2294.066,3.2906289584; 2294.566,3.2453556336;
            2295.066,3.2618186608; 2295.567,3.2618186608; 2296.066,3.2823974448;
            2296.565,3.3441337968; 2297.066,3.2535871472; 2297.566,3.2330083632;
            2298.065,3.2330083632; 2298.565,3.2124295792; 2299.065,3.257702904;
            2299.566,3.278281688; 2300.064,3.257702904; 2300.566,3.23712412;
            2301.065,3.2247768496; 2301.566,3.2330083632; 2302.065,3.2535871472;
            2302.565,3.2618186608; 2303.066,3.2206610928; 2303.566,3.2865132016;
            2304.066,3.3029762288; 2304.565,3.23712412; 2305.066,3.2659344176;
            2305.564,3.298860472; 2306.065,3.2247768496; 2306.565,3.3235550128;
            2307.065,3.2494713904; 2307.563,3.3029762288; 2308.064,3.2865132016;
            2308.565,3.2947447152; 2309.064,3.2865132016; 2309.565,3.3153234992;
            2310.064,3.298860472; 2310.566,3.319439256; 2311.066,3.3359022832;
            2311.564,3.3112077424; 2312.067,3.3112077424; 2312.566,3.2823974448;
            2313.066,3.3112077424; 2313.566,3.2041980656; 2314.066,3.2124295792;
            2314.566,3.1836192816; 2315.065,3.1589247408; 2315.567,3.1795035248;
            2316.066,3.2330083632; 2316.566,3.2453556336; 2317.067,3.2330083632;
            2317.567,3.1836192816; 2318.063,3.175387768; 2318.567,3.2000823088;
            2319.065,3.1424617136; 2319.567,3.1424617136; 2320.066,3.1301144432;
            2320.565,3.1630404976; 2321.067,3.113651416; 2321.566,3.1301144432;
            2322.064,3.0971883888; 2322.566,3.1712720112; 2323.066,3.0971883888;
            2323.565,3.195966552; 2324.066,3.093072632; 2324.566,3.0766096048;
            2325.065,3.0848411184; 2325.565,3.1218829296; 2326.066,3.1589247408;
            2326.565,3.1301144432; 2327.065,3.1177671728; 2327.565,3.1712720112;
            2328.062,3.195966552; 2328.564,3.1712720112; 2329.066,3.2000823088;
            2329.565,3.1383459568; 2330.066,3.1342302; 2330.567,3.1301144432;
            2331.065,3.1795035248; 2331.565,3.1671562544; 2332.065,3.1630404976;
            2332.565,3.1630404976; 2333.066,3.1177671728; 2333.567,3.1383459568;
            2334.067,3.1342302; 2334.567,3.0642623344; 2335.066,3.1506932272;
            2335.565,3.1671562544; 2336.066,3.1795035248; 2336.565,3.1795035248;
            2337.065,3.154808984; 2337.565,3.2000823088; 2338.066,3.1918507952;
            2338.565,3.195966552; 2339.066,3.2000823088; 2339.566,3.175387768;
            2340.066,3.1712720112; 2340.567,3.216545336; 2341.066,3.195966552;
            2341.567,3.1918507952; 2342.065,3.1630404976; 2342.566,3.1836192816;
            2343.066,3.216545336; 2343.565,3.1836192816; 2344.063,3.23712412;
            2344.567,3.1918507952; 2345.064,3.2041980656; 2345.564,3.1301144432;
            2346.065,3.1630404976; 2346.567,3.1218829296; 2347.063,3.1877350384;
            2347.564,3.1259986864; 2348.064,3.1383459568; 2348.565,3.1589247408;
            2349.067,3.1095356592; 2349.564,3.1054199024; 2350.065,3.0642623344;
            2350.565,3.1259986864; 2351.065,3.0971883888; 2351.566,3.1013041456;
            2352.066,3.0889568752; 2352.564,3.1259986864; 2353.065,3.1095356592;
            2353.564,3.0848411184; 2354.065,3.072493848; 2354.564,3.1424617136;
            2355.063,3.1424617136; 2355.563,3.1013041456; 2356.066,3.1218829296;
            2356.565,3.1301144432; 2357.063,3.1424617136; 2357.565,3.1259986864;
            2358.061,3.1301144432; 2358.566,3.1054199024; 2359.066,3.1095356592;
            2359.566,3.1218829296; 2360.064,3.1259986864; 2360.565,3.1465774704;
            2361.066,3.1342302; 2361.567,3.1424617136; 2362.065,3.1918507952;
            2362.565,3.2330083632; 2363.066,3.298860472; 2363.566,3.2947447152;
            2364.066,3.2823974448; 2364.567,3.2412398768; 2365.066,3.1918507952;
            2365.565,3.195966552; 2366.099,3.1424617136; 2366.567,3.1712720112;
            2367.065,3.1918507952; 2367.563,3.1013041456; 2368.066,3.1301144432;
            2368.565,3.1177671728; 2369.064,3.113651416; 2369.566,3.2247768496;
            2370.064,3.1836192816; 2370.566,3.195966552; 2371.067,3.2000823088;
            2371.565,3.1342302; 2372.066,3.154808984; 2372.566,3.1671562544;
            2373.066,3.2041980656; 2373.566,3.113651416; 2374.067,3.0889568752;
            2374.566,3.0766096048; 2375.065,3.0683780912; 2375.565,3.1054199024;
            2376.067,3.1630404976; 2376.565,3.216545336; 2377.066,3.1918507952;
            2377.566,3.1589247408; 2378.066,3.1918507952; 2378.565,3.216545336;
            2379.065,3.2124295792; 2379.566,3.2494713904; 2380.065,3.175387768;
            2380.566,3.2083138224; 2381.065,3.2494713904; 2381.566,3.2330083632;
            2382.066,3.154808984; 2382.565,3.175387768; 2383.065,3.2083138224;
            2383.563,3.175387768; 2384.063,3.1013041456; 2384.566,3.1218829296;
            2385.067,3.1301144432; 2385.566,3.0807253616; 2386.065,3.1506932272;
            2386.565,3.113651416; 2387.067,3.1013041456; 2387.566,3.0971883888;
            2388.065,3.113651416; 2388.565,3.113651416; 2389.066,3.1218829296;
            2389.566,3.113651416; 2390.067,3.113651416; 2390.565,3.1342302;
            2391.066,3.1301144432; 2391.564,3.1671562544; 2392.065,3.1259986864;
            2392.567,3.0889568752; 2393.065,3.0807253616; 2393.566,3.0889568752;
            2394.065,3.0354520368; 2394.565,3.113651416; 2395.066,3.093072632;
            2395.564,3.1095356592; 2396.064,3.1177671728; 2396.565,3.1095356592;
            2397.065,3.093072632; 2397.563,3.1671562544; 2398.066,3.2000823088;
            2398.566,3.1795035248; 2399.067,3.2453556336; 2399.566,3.2288926064;
            2400.066,3.2659344176; 2400.564,3.2247768496; 2401.066,3.2535871472;
            2401.567,3.1630404976; 2402.065,3.2494713904; 2402.567,3.1795035248;
            2403.064,3.2041980656; 2403.565,3.1918507952; 2404.064,3.195966552;
            2404.565,3.1836192816; 2405.065,3.2041980656; 2405.566,3.1506932272;
            2406.066,3.1589247408; 2406.566,3.1589247408; 2407.064,3.154808984;
            2407.566,3.1630404976; 2408.066,3.175387768; 2408.563,3.1671562544;
            2409.066,3.1671562544; 2409.566,3.1671562544; 2410.066,3.1054199024;
            2410.566,3.1877350384; 2411.065,3.1795035248; 2411.562,3.1465774704;
            2412.066,3.1671562544; 2412.565,3.1712720112; 2413.066,3.1383459568;
            2413.565,3.1630404976; 2414.065,3.175387768; 2414.567,3.1301144432;
            2415.065,3.1630404976; 2415.566,3.1589247408; 2416.067,3.1836192816;
            2416.567,3.1218829296; 2417.066,3.1589247408; 2417.565,3.0766096048;
            2418.065,3.0971883888; 2418.563,3.0766096048; 2419.066,3.1877350384;
            2419.563,3.1671562544; 2420.065,3.2041980656; 2420.564,3.2000823088;
            2421.066,3.195966552; 2421.567,3.1671562544; 2422.066,3.175387768;
            2422.567,3.2041980656; 2423.065,3.216545336; 2423.565,3.2247768496;
            2424.063,3.2041980656; 2424.565,3.2330083632; 2425.067,3.1918507952;
            2425.563,3.2453556336; 2426.064,3.2124295792; 2426.567,3.195966552;
            2427.066,3.1465774704; 2427.565,3.1836192816; 2428.066,3.1465774704;
            2428.566,3.1506932272; 2429.066,3.154808984; 2429.566,3.1589247408;
            2430.066,3.1506932272; 2430.565,3.1671562544; 2431.066,3.1383459568;
            2431.565,3.1424617136; 2432.066,3.1177671728; 2432.567,3.072493848;
            2433.066,3.1095356592; 2433.565,3.0807253616; 2434.067,3.113651416;
            2434.565,3.0807253616; 2435.065,3.072493848; 2435.562,3.0807253616;
            2436.067,3.0848411184; 2436.564,3.1013041456; 2437.066,3.072493848;
            2437.567,3.1259986864; 2438.066,3.1177671728; 2438.567,3.1465774704;
            2439.066,3.093072632; 2439.567,3.1259986864; 2440.066,3.1054199024;
            2440.567,3.1177671728; 2441.067,3.1177671728; 2441.563,3.1671562544;
            2442.062,3.1630404976; 2442.563,3.1630404976; 2443.067,3.1506932272;
            2443.565,3.1342302; 2444.066,3.1218829296; 2444.562,3.113651416;
            2445.065,3.1342302; 2445.567,3.1095356592; 2446.065,3.1671562544;
            2446.566,3.1095356592; 2447.066,3.1301144432; 2447.565,3.1342302;
            2448.066,3.154808984; 2448.565,3.1506932272; 2449.064,3.1177671728;
            2449.565,3.1589247408; 2450.066,3.1630404976; 2450.565,3.1465774704;
            2451.065,3.154808984; 2451.566,3.2000823088; 2452.067,3.1630404976;
            2452.564,3.175387768; 2453.066,3.2288926064; 2453.566,3.2741659312;
            2454.065,3.2741659312; 2454.565,3.2906289584; 2455.066,3.2618186608;
            2455.566,3.2535871472; 2456.064,3.1671562544; 2456.565,3.2000823088;
            2457.065,3.1712720112; 2457.565,3.1301144432; 2458.066,3.1836192816;
            2458.566,3.1218829296; 2459.067,3.1424617136; 2459.566,3.1054199024;
            2460.065,3.0971883888; 2460.565,3.175387768; 2461.066,3.1836192816;
            2461.566,3.1465774704; 2462.066,3.1671562544; 2462.565,3.175387768;
            2463.065,3.1712720112; 2463.567,3.1630404976; 2464.065,3.1630404976;
            2464.567,3.1918507952; 2465.065,3.1795035248; 2465.561,3.1177671728;
            2466.066,3.1795035248; 2466.564,3.1177671728; 2467.066,3.154808984;
            2467.566,3.1465774704; 2468.065,3.0889568752; 2468.566,3.1095356592;
            2469.065,3.1424617136; 2469.565,3.1671562544; 2470.066,3.1589247408;
            2470.565,3.1795035248; 2471.064,3.1836192816; 2471.566,3.2000823088;
            2472.062,3.1424617136; 2472.566,3.1259986864; 2473.066,3.175387768;
            2473.566,3.216545336; 2474.067,3.2247768496; 2474.566,3.2000823088;
            2475.065,3.175387768; 2475.565,3.2083138224; 2476.063,3.195966552;
            2476.566,3.2412398768; 2477.066,3.1795035248; 2477.565,3.1671562544;
            2478.067,3.1877350384; 2478.565,3.1795035248; 2479.067,3.1589247408;
            2479.566,3.0848411184; 2480.065,3.1259986864; 2480.566,3.1630404976;
            2481.066,3.1054199024; 2481.564,3.1054199024; 2482.065,3.1259986864;
            2482.567,3.1342302; 2483.066,3.1259986864; 2483.565,3.0971883888;
            2484.067,3.0807253616; 2484.564,3.1054199024; 2485.066,3.0601465776;
            2485.566,3.0683780912; 2486.066,3.0560308208; 2486.565,3.1095356592;
            2487.065,3.1054199024; 2487.564,3.0683780912; 2488.065,3.1095356592;
            2488.562,3.1013041456; 2489.065,3.113651416; 2489.565,3.1259986864;
            2490.066,3.1301144432; 2490.565,3.1342302; 2491.064,3.1589247408;
            2491.566,3.1383459568; 2492.065,3.154808984; 2492.565,3.1506932272;
            2493.064,3.1671562544; 2493.566,3.1301144432; 2494.065,3.113651416;
            2494.562,3.0848411184; 2495.063,3.1095356592; 2495.564,3.1383459568;
            2496.063,3.1259986864; 2496.566,3.154808984; 2497.067,3.1301144432;
            2497.565,3.1424617136; 2498.063,3.1177671728; 2498.566,3.1259986864;
            2499.063,3.1465774704; 2499.565,3.195966552; 2500.065,3.175387768;
            2500.567,3.1836192816; 2501.063,3.1177671728; 2501.567,3.154808984;
            2502.065,3.1506932272; 2502.566,3.1589247408; 2503.067,3.1177671728;
            2503.565,3.1795035248; 2504.066,3.1424617136; 2504.565,3.1424617136;
            2505.066,3.1506932272; 2505.566,3.1054199024; 2506.064,3.1712720112;
            2506.565,3.1630404976; 2507.066,3.1836192816; 2507.566,3.1836192816;
            2508.067,3.1918507952; 2508.565,3.2124295792; 2509.063,3.2083138224;
            2509.565,3.2330083632; 2510.065,3.2041980656; 2510.567,3.2823974448;
            2511.064,3.2494713904; 2511.565,3.2700501744; 2512.067,3.2700501744;
            2512.566,3.2412398768; 2513.066,3.2618186608; 2513.566,3.3647125808;
            2514.066,3.3359022832; 2514.566,3.3070919856; 2515.066,3.319439256;
            2515.565,3.3029762288; 2516.062,3.3029762288; 2516.563,3.3070919856;
            2517.064,3.257702904; 2517.567,3.2453556336; 2518.067,3.278281688;
            2518.565,3.2247768496; 2519.067,3.2412398768; 2519.566,3.2124295792;
            2520.067,3.2083138224; 2520.565,3.2124295792; 2521.063,3.2041980656;
            2521.564,3.2083138224; 2522.066,3.2412398768; 2522.565,3.2453556336;
            2523.066,3.1630404976; 2523.563,3.216545336; 2524.065,3.1877350384;
            2524.564,3.2206610928; 2525.065,3.1506932272; 2525.567,3.1424617136;
            2526.064,3.1671562544; 2526.566,3.1095356592; 2527.066,3.1424617136;
            2527.566,3.1795035248; 2528.066,3.1342302; 2528.566,3.1465774704;
            2529.066,3.1506932272; 2529.567,3.195966552; 2530.066,3.154808984;
            2530.566,3.1465774704; 2531.066,3.175387768; 2531.564,3.1342302;
            2532.066,3.1589247408; 2532.568,3.175387768; 2533.067,3.175387768;
            2533.566,3.2000823088; 2534.064,3.1506932272; 2534.566,3.2000823088;
            2535.065,3.195966552; 2535.567,3.1918507952; 2536.066,3.1918507952;
            2536.566,3.2041980656; 2537.066,3.1836192816; 2537.566,3.2206610928;
            2538.067,3.2041980656; 2538.566,3.1712720112; 2539.067,3.1589247408;
            2539.567,3.1918507952; 2540.067,3.2247768496; 2540.566,3.1795035248;
            2541.067,3.2000823088; 2541.566,3.1671562544; 2542.067,3.195966552;
            2542.566,3.1795035248; 2543.065,3.1712720112; 2543.566,3.1465774704;
            2544.066,3.1671562544; 2544.568,3.1177671728; 2545.066,3.1506932272;
            2545.566,3.1712720112; 2546.067,3.1465774704; 2546.567,3.1465774704;
            2547.065,3.175387768; 2547.567,3.0971883888; 2548.067,3.1918507952;
            2548.566,3.1259986864; 2549.065,3.1259986864; 2549.565,3.0889568752;
            2550.066,3.1465774704; 2550.565,3.1013041456; 2551.066,3.1218829296;
            2551.566,3.113651416; 2552.067,3.1712720112; 2552.565,3.113651416;
            2553.065,3.154808984; 2553.566,3.1465774704; 2554.072,3.1465774704],
        tableName="topValve",
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents)
        annotation (Placement(transformation(extent={{-46,40},{-26,60}})));
      Modelica.Blocks.Sources.CombiTimeTable HeaterPower(
        tableOnFile=false,
        table=[0,9.1350036144; 0.57,9.1103090736; 1.061,9.1391193712; 1.56,
            9.0979618032; 2.063,9.1926242096; 2.562,9.1596981552; 3.062,
            9.122656344; 3.562,9.163813912; 4.062,9.1185405872; 4.562,
            9.1350036144; 5.059,9.0897302896; 5.562,9.0362254512; 6.062,
            9.0238781808; 6.563,8.9539103152; 7.061,8.99918364; 7.563,
            8.978604856; 8.061,9.0074151536; 8.561,8.99918364; 9.061,
            9.0279939376; 9.562,8.9950678832; 10.061,9.0321096944; 10.562,
            9.0074151536; 11.061,9.081498776; 11.563,9.0732672624; 12.06,
            9.1185405872; 12.561,9.0938460464; 13.061,9.0156466672; 13.562,
            9.0444569648; 14.059,9.0568042352; 14.561,9.081498776; 15.061,
            9.0279939376; 15.562,9.0321096944; 16.06,9.0691515056; 16.559,
            9.0938460464; 17.062,9.0773830192; 17.562,9.1267721008; 18.062,
            9.0856145328; 18.56,9.10207756; 19.063,9.1185405872; 19.562,
            9.0979618032; 20.062,9.1720454256; 20.561,9.1761611824; 21.062,
            9.1885084528; 21.561,9.1473508848; 22.061,9.0485727216; 22.562,
            9.0485727216; 23.061,9.0732672624; 23.561,9.0691515056; 24.062,
            9.0238781808; 24.561,9.040341208; 25.063,9.0115309104; 25.561,
            9.081498776; 26.062,9.1144248304; 26.561,9.1267721008; 27.062,
            9.1802769392; 27.562,9.1391193712; 28.061,9.20497148; 28.562,
            9.1308878576; 29.062,9.10207756; 29.563,9.184392696; 30.062,
            9.163813912; 30.562,9.1555823984; 31.062,9.122656344; 31.563,
            9.184392696; 32.061,9.20497148; 32.559,9.1761611824; 33.063,
            9.1391193712; 33.56,9.122656344; 34.06,9.0691515056; 34.561,
            9.0938460464; 35.061,9.1144248304; 35.56,9.1267721008; 36.062,
            9.1391193712; 36.562,9.1061933168; 37.061,9.0856145328; 37.562,
            9.10207756; 38.061,9.0691515056; 38.56,9.0938460464; 39.06,
            9.0938460464; 39.563,9.0238781808; 40.061,9.0691515056; 40.562,
            9.1350036144; 41.061,9.0856145328; 41.561,9.040341208; 42.063,
            9.0526884784; 42.56,8.99918364; 43.061,9.0526884784; 43.558,
            9.0732672624; 44.061,9.1391193712; 44.562,8.9909521264; 45.062,
            9.019762424; 45.56,9.0238781808; 46.064,9.0156466672; 46.562,
            9.0485727216; 47.06,9.0773830192; 47.56,9.0732672624; 48.061,
            9.1267721008; 48.561,9.1885084528; 49.061,9.1926242096; 49.561,
            9.1720454256; 50.061,9.1391193712; 50.561,9.1350036144; 51.062,
            9.143235128; 51.56,9.1473508848; 52.061,9.1185405872; 52.561,
            9.1185405872; 53.062,9.1185405872; 53.562,9.0732672624; 54.058,
            9.1144248304; 54.56,9.0938460464; 55.06,9.1514666416; 55.561,
            9.122656344; 56.062,9.1308878576; 56.562,9.1185405872; 57.061,
            9.184392696; 57.561,9.2337817776; 58.061,9.20497148; 58.559,
            9.225550264; 59.058,9.2584763184; 59.558,9.266707832; 60.058,
            9.2132029936; 60.559,9.1267721008; 61.06,9.1144248304; 61.56,
            9.0856145328; 62.061,9.0773830192; 62.56,8.99918364; 63.058,
            9.0156466672; 63.56,9.0032993968; 64.059,9.019762424; 64.559,
            9.0321096944; 65.063,9.0526884784; 65.561,9.0444569648; 66.062,
            9.0773830192; 66.561,9.040341208; 67.061,9.0526884784; 67.562,
            9.0938460464; 68.062,9.081498776; 68.561,9.1103090736; 69.062,
            9.1308878576; 69.562,9.1514666416; 70.061,9.1391193712; 70.561,
            9.1555823984; 71.061,9.0938460464; 71.561,9.1308878576; 72.061,
            9.1061933168; 72.558,9.1185405872; 73.062,9.1473508848; 73.562,
            9.1720454256; 74.062,9.1967399664; 74.561,9.2008557232; 75.062,
            9.1185405872; 75.561,9.1679296688; 76.061,9.1185405872; 76.562,
            9.1555823984; 77.062,9.1350036144; 77.562,9.1391193712; 78.062,
            9.1308878576; 78.563,9.143235128; 79.061,9.1473508848; 79.56,
            9.1185405872; 80.061,9.1267721008; 80.561,9.0279939376; 81.062,
            9.0321096944; 81.561,9.0444569648; 82.061,9.1761611824; 82.561,
            9.1802769392; 83.061,9.1720454256; 83.562,9.1761611824; 84.06,
            9.2132029936; 84.56,9.1596981552; 85.063,9.1596981552; 85.562,
            9.1473508848; 86.062,9.1679296688; 86.561,9.1926242096; 87.062,
            9.2214345072; 87.561,9.2625920752; 88.062,9.2296660208; 88.561,
            9.2132029936; 89.061,9.20497148; 89.562,9.2502448048; 90.062,
            9.2337817776; 90.562,9.225550264; 91.061,9.1761611824; 91.561,
            9.2008557232; 92.061,9.184392696; 92.561,9.1802769392; 93.061,
            9.1761611824; 93.56,9.1761611824; 94.061,9.122656344; 94.561,
            9.1185405872; 95.061,9.1555823984; 95.561,9.1103090736; 96.071,
            9.0238781808; 96.561,9.0279939376; 97.063,9.0856145328; 97.562,
            9.1350036144; 98.062,9.1308878576; 98.561,9.0773830192; 99.062,
            9.1061933168; 99.562,9.0732672624; 100.063,9.143235128; 100.563,
            9.0732672624; 101.061,9.0856145328; 101.562,9.0979618032; 102.062,
            9.1185405872; 102.561,9.0773830192; 103.061,9.0568042352; 103.563,
            9.1103090736; 104.063,9.0568042352; 104.562,9.0732672624; 105.091,
            9.1144248304; 105.559,9.1267721008; 106.061,9.0979618032; 106.56,
            9.060919992; 107.061,9.060919992; 107.56,8.9909521264; 108.062,
            9.0568042352; 108.561,9.0444569648; 109.061,9.0526884784; 109.561,
            9.0979618032; 110.062,9.0732672624; 110.561,9.060919992; 111.061,
            9.10207756; 111.561,9.122656344; 112.06,9.0856145328; 112.562,
            9.1061933168; 113.059,9.1350036144; 113.562,9.060919992; 114.062,
            9.0773830192; 114.561,9.1061933168; 115.063,9.1761611824; 115.562,
            9.1720454256; 116.063,9.1679296688; 116.561,9.2173187504; 117.063,
            9.1720454256; 117.562,9.184392696; 118.061,9.1885084528; 118.561,
            9.1802769392; 119.062,9.184392696; 119.563,9.163813912; 120.062,
            9.1267721008; 120.563,9.1103090736; 121.061,9.1473508848; 121.562,
            9.2090872368; 122.061,9.1802769392; 122.562,9.163813912; 123.063,
            9.184392696; 123.562,9.1555823984; 124.063,9.143235128; 124.563,
            9.1350036144; 125.062,9.143235128; 125.561,9.1555823984; 126.062,
            9.1391193712; 126.56,9.184392696; 127.061,9.1885084528; 127.564,
            9.1761611824; 128.063,9.1267721008; 128.563,9.0444569648; 129.075,
            9.0650357488; 129.562,9.0279939376; 130.061,8.9909521264; 130.56,
            9.0568042352; 131.063,9.1103090736; 131.561,9.1350036144; 132.06,
            9.1061933168; 132.561,9.1596981552; 133.06,9.1473508848; 133.56,
            9.143235128; 134.062,9.1596981552; 134.561,9.163813912; 135.06,
            9.1555823984; 135.562,9.1391193712; 136.062,9.1555823984; 136.559,
            9.1802769392; 137.059,9.1514666416; 137.559,9.2008557232; 138.07,
            9.163813912; 138.56,9.122656344; 139.062,9.1308878576; 139.558,
            9.1103090736; 140.061,9.081498776; 140.561,9.1144248304; 141.06,
            9.1061933168; 141.562,9.10207756; 142.062,9.081498776; 142.562,
            9.0691515056; 143.061,9.0568042352; 143.562,8.9868363696; 144.062,
            9.0279939376; 144.562,9.0362254512; 145.06,9.0691515056; 145.562,
            9.0897302896; 146.062,9.081498776; 146.558,9.0979618032; 147.064,
            9.0650357488; 147.562,9.081498776; 148.06,9.081498776; 148.562,
            9.0568042352; 149.062,9.122656344; 149.562,9.0732672624; 150.062,
            9.1267721008; 150.562,9.0897302896; 151.06,9.0444569648; 151.563,
            9.0032993968; 152.062,9.0279939376; 152.561,9.0156466672; 153.064,
            9.040341208; 153.562,9.060919992; 154.062,9.0526884784; 154.562,
            9.1267721008; 155.059,9.1473508848; 155.562,9.1885084528; 156.061,
            9.2625920752; 156.56,9.246129048; 157.063,9.3037496432; 157.563,
            9.246129048; 158.061,9.2378975344; 158.563,9.2502448048; 159.061,
            9.225550264; 159.56,9.20497148; 160.062,9.1885084528; 160.562,
            9.1926242096; 161.062,9.1267721008; 161.558,9.1679296688; 162.062,
            9.10207756; 162.567,9.1144248304; 163.061,9.1802769392; 163.561,
            9.1350036144; 164.061,9.1267721008; 164.559,9.1514666416; 165.06,
            9.0979618032; 165.558,9.143235128; 166.059,9.1391193712; 166.559,
            9.1761611824; 167.059,9.060919992; 167.559,9.1391193712; 168.062,
            9.1185405872; 168.558,9.1103090736; 169.06,9.1185405872; 169.562,
            9.143235128; 170.062,9.1391193712; 170.561,9.143235128; 171.065,
            9.1473508848; 171.559,9.1514666416; 172.062,9.1761611824; 172.56,
            9.1802769392; 173.059,9.1967399664; 173.56,9.1926242096; 174.06,
            9.1802769392; 174.56,9.1514666416; 175.059,9.1885084528; 175.559,
            9.1679296688; 176.062,9.1514666416; 176.56,9.1061933168; 177.061,
            9.1308878576; 177.561,9.0979618032; 178.06,9.060919992; 178.558,
            9.081498776; 179.06,9.1350036144; 179.559,9.0979618032; 180.06,
            9.081498776; 180.561,9.081498776; 181.061,9.081498776; 181.559,
            9.1061933168; 182.061,9.1103090736; 182.56,9.1144248304; 183.062,
            9.1391193712; 183.562,9.143235128; 184.06,9.10207756; 184.563,
            9.1308878576; 185.061,9.143235128; 185.562,9.1308878576; 186.059,
            9.1103090736; 186.559,9.1555823984; 187.062,9.1308878576; 187.562,
            9.1514666416; 188.061,9.1967399664; 188.559,9.1761611824; 189.061,
            9.2420132912; 189.561,9.1885084528; 190.062,9.1885084528; 190.561,
            9.163813912; 191.062,9.1885084528; 191.558,9.1926242096; 192.06,
            9.0897302896; 192.559,9.0650357488; 193.062,9.1350036144; 193.561,
            9.0691515056; 194.062,8.9909521264; 194.562,9.0568042352; 195.062,
            9.0485727216; 195.562,9.060919992; 196.058,9.0691515056; 196.558,
            9.10207756; 197.061,9.0938460464; 197.561,9.0732672624; 198.062,
            9.122656344; 198.563,9.0568042352; 199.061,9.10207756; 199.561,
            9.0938460464; 200.062,9.0732672624; 200.559,9.1473508848; 201.062,
            9.0897302896; 201.559,9.163813912; 202.062,9.143235128; 202.561,
            9.1596981552; 203.062,9.143235128; 203.563,9.143235128; 204.061,
            9.1144248304; 204.563,9.1926242096; 205.062,9.1308878576; 205.562,
            9.1473508848; 206.061,9.1350036144; 206.56,9.1144248304; 207.06,
            9.143235128; 207.562,9.1391193712; 208.062,9.0979618032; 208.559,
            9.0938460464; 209.062,9.0773830192; 209.562,9.0732672624; 210.061,
            9.0897302896; 210.562,9.1103090736; 211.063,9.143235128; 211.562,
            9.10207756; 212.062,9.1885084528; 212.562,9.122656344; 213.062,
            9.1514666416; 213.561,9.143235128; 214.061,9.1473508848; 214.559,
            9.1926242096; 215.062,9.2090872368; 215.562,9.2008557232; 216.061,
            9.1967399664; 216.563,9.2584763184; 217.059,9.2543605616; 217.562,
            9.2543605616; 218.062,9.2378975344; 218.563,9.1761611824; 219.063,
            9.163813912; 219.56,9.1967399664; 220.062,9.2090872368; 220.562,
            9.20497148; 221.061,9.225550264; 221.563,9.2296660208; 222.061,
            9.2132029936; 222.562,9.2090872368; 223.061,9.1885084528; 223.562,
            9.2008557232; 224.061,9.2173187504; 224.56,9.2173187504; 225.063,
            9.2173187504; 225.562,9.1596981552; 226.062,9.143235128; 226.56,
            9.122656344; 227.061,9.1679296688; 227.561,9.163813912; 228.062,
            9.2337817776; 228.561,9.246129048; 229.059,9.2214345072; 229.561,
            9.246129048; 230.062,9.246129048; 230.561,9.246129048; 231.062,
            9.2132029936; 231.56,9.1967399664; 232.062,9.1802769392; 232.563,
            9.163813912; 233.06,9.1802769392; 233.562,9.184392696; 234.06,
            9.1926242096; 234.56,9.1802769392; 235.06,9.184392696; 235.561,
            9.1761611824; 236.062,9.1679296688; 236.561,9.184392696; 237.062,
            9.1555823984; 237.561,9.1596981552; 238.061,9.1885084528; 238.562,
            9.1473508848; 239.062,9.163813912; 239.559,9.1267721008; 240.061,
            9.1596981552; 240.559,9.1761611824; 241.061,9.184392696; 241.559,
            9.1761611824; 242.061,9.1967399664; 242.558,9.2296660208; 243.062,
            9.2132029936; 243.562,9.2214345072; 244.061,9.20497148; 244.561,
            9.2090872368; 245.061,9.246129048; 245.559,9.2337817776; 246.061,
            9.2543605616; 246.56,9.2914023728; 247.062,9.2502448048; 247.561,
            9.266707832; 248.059,9.2337817776; 248.561,9.2584763184; 249.06,
            9.2378975344; 249.562,9.1926242096; 250.063,9.2337817776; 250.561,
            9.1885084528; 251.06,9.1926242096; 251.561,9.2132029936; 252.06,
            9.1720454256; 252.562,9.163813912; 253.06,9.1679296688; 253.561,
            9.1308878576; 254.062,9.1473508848; 254.562,9.1308878576; 255.058,
            9.1679296688; 255.562,9.20908723680001; 256.063,9.1679296688;
            256.562,9.2337817776; 257.061,9.2378975344; 257.563,9.2296660208;
            258.059,9.2296660208; 258.567,9.2173187504; 259.062,9.2337817776;
            259.562,9.2296660208; 260.063,9.2584763184; 260.558,9.2337817776;
            261.058,9.2749393456; 261.559,9.246129048; 262.059,9.2420132912;
            262.56,9.2502448048; 263.059,9.266707832; 263.559,9.2955181296;
            264.062,9.2378975344; 264.559,9.2214345072; 265.059,9.2296660208;
            265.562,9.246129048; 266.062,9.1473508848; 266.562,9.1967399664;
            267.06,9.1350036144; 267.563,9.1885084528; 268.062,9.1061933168;
            268.561,9.1514666416; 269.061,9.1555823984; 269.561,9.1555823984;
            270.062,9.1473508848; 270.561,9.163813912; 271.062,9.1391193712;
            271.562,9.1185405872; 272.062,9.122656344; 272.562,9.143235128;
            273.062,9.1103090736; 273.562,9.1802769392; 274.063,9.1596981552;
            274.562,9.1514666416; 275.062,9.1391193712; 275.563,9.0979618032;
            276.064,9.1596981552; 276.559,9.1514666416; 277.062,9.1967399664;
            277.561,9.1926242096; 278.061,9.1802769392; 278.563,9.184392696;
            279.062,9.1720454256; 279.561,9.163813912; 280.062,9.1720454256;
            280.562,9.1720454256; 281.061,9.1596981552; 281.559,9.1679296688;
            282.062,9.1802769392; 282.561,9.1555823984; 283.062,9.1679296688;
            283.563,9.1885084528; 284.059,9.1514666416; 284.562,9.1761611824;
            285.061,9.20497148; 285.561,9.2420132912; 286.062,9.225550264;
            286.56,9.2584763184; 287.061,9.2790551024; 287.559,9.2214345072;
            288.062,9.2173187504; 288.562,9.184392696; 289.062,9.2543605616;
            289.564,9.2625920752; 290.062,9.225550264; 290.563,9.1926242096;
            291.059,9.122656344; 291.559,9.122656344; 292.062,9.1761611824;
            292.563,9.266707832; 293.062,9.2790551024; 293.563,9.1596981552;
            294.062,9.1720454256; 294.559,9.122656344; 295.063,9.1308878576;
            295.561,9.1267721008; 296.061,9.1596981552; 296.561,9.20497148;
            297.061,9.1596981552; 297.563,9.2132029936; 298.061,9.2008557232;
            298.561,9.2214345072; 299.061,9.2008557232; 299.559,9.225550264;
            300.063,9.1885084528; 300.561,9.2008557232; 301.061,9.2008557232;
            301.564,9.225550264; 302.061,9.1967399664; 302.562,9.2090872368;
            303.063,9.2502448048; 303.562,9.2090872368; 304.062,9.2296660208;
            304.562,9.225550264; 305.062,9.2173187504; 305.561,9.2378975344;
            306.063,9.1761611824; 306.563,9.2337817776; 307.064,9.2214345072;
            307.561,9.2008557232; 308.061,9.246129048; 308.564,9.2214345072;
            309.063,9.2378975344; 309.563,9.246129048; 310.061,9.2584763184;
            310.561,9.2296660208; 311.062,9.225550264; 311.562,9.2337817776;
            312.062,9.225550264; 312.561,9.2296660208; 313.06,9.2173187504;
            313.562,9.2214345072; 314.062,9.2008557232; 314.562,9.2214345072;
            315.062,9.20497148; 315.561,9.1802769392; 316.062,9.266707832;
            316.562,9.2337817776; 317.062,9.2543605616; 317.56,9.2502448048;
            318.063,9.2296660208; 318.561,9.2502448048; 319.064,9.1967399664;
            319.561,9.2090872368; 320.063,9.2420132912; 320.561,9.2214345072;
            321.062,9.246129048; 321.563,9.2090872368; 322.062,9.1926242096;
            322.56,9.225550264; 323.062,9.2090872368; 323.563,9.225550264;
            324.064,9.2584763184; 324.562,9.2420132912; 325.063,9.3037496432;
            325.561,9.2625920752; 326.064,9.2625920752; 326.563,9.2214345072;
            327.062,9.2420132912; 327.563,9.2708235888; 328.063,9.2955181296;
            328.561,9.287286616; 329.061,9.2914023728; 329.561,9.2584763184;
            330.061,9.2214345072; 330.563,9.225550264; 331.061,9.1802769392;
            331.563,9.2008557232; 332.064,9.2749393456; 332.562,9.2749393456;
            333.062,9.2543605616; 333.561,9.3037496432; 334.062,9.2625920752;
            334.561,9.3119811568; 335.062,9.2914023728; 335.562,9.3243284272;
            336.063,9.2996338864; 336.562,9.3325599408; 337.062,9.390180536;
            337.562,9.41075932; 338.062,9.3942962928; 338.561,9.41075932;
            339.062,9.3531387248; 339.563,9.3243284272; 340.063,9.2955181296;
            340.563,9.2831708592; 341.063,9.2543605616; 341.558,9.2337817776;
            342.06,9.2378975344; 342.561,9.2296660208; 343.061,9.2502448048;
            343.563,9.246129048; 344.06,9.2296660208; 344.564,9.2090872368;
            345.063,9.2831708592; 345.563,9.266707832; 346.059,9.3160969136;
            346.562,9.287286616; 347.062,9.328444184; 347.562,9.3243284272;
            348.062,9.3119811568; 348.563,9.3243284272; 349.062,9.3572544816;
            349.563,9.3449072112; 350.063,9.3737175088; 350.562,9.3613702384;
            351.062,9.3078654; 351.561,9.3037496432; 352.062,9.2790551024;
            352.561,9.2378975344; 353.061,9.2337817776; 353.562,9.2584763184;
            354.062,9.2955181296; 354.562,9.3202126704; 355.062,9.3037496432;
            355.563,9.328444184; 356.062,9.3202126704; 356.56,9.3449072112;
            357.062,9.3654859952; 357.561,9.3984120496; 358.062,9.369601752;
            358.561,9.287286616; 359.064,9.2749393456; 359.561,9.3613702384;
            360.062,9.2996338864; 360.562,9.2914023728; 361.059,9.2625920752;
            361.564,9.246129048; 362.063,9.3202126704; 362.558,9.2831708592;
            363.061,9.225550264; 363.563,9.2914023728; 364.062,9.2132029936;
            364.561,9.2543605616; 365.061,9.266707832; 365.56,9.2708235888;
            366.063,9.2831708592; 366.56,9.2584763184; 367.062,9.2502448048;
            367.562,9.2708235888; 368.062,9.2996338864; 368.562,9.2708235888;
            369.063,9.2914023728; 369.558,9.3160969136; 370.061,9.3078654;
            370.563,9.3325599408; 371.063,9.3037496432; 371.561,9.3037496432;
            372.064,9.3654859952; 372.561,9.349022968; 373.062,9.328444184;
            373.563,9.2831708592; 374.061,9.2584763184; 374.561,9.3119811568;
            375.061,9.2996338864; 375.562,9.3119811568; 376.063,9.2955181296;
            376.562,9.3531387248; 377.061,9.2996338864; 377.561,9.3366756976;
            378.061,9.3119811568; 378.561,9.3613702384; 379.062,9.3325599408;
            379.562,9.3572544816; 380.062,9.3654859952; 380.561,9.3737175088;
            381.063,9.2914023728; 381.563,9.3119811568; 382.062,9.3078654;
            382.564,9.3202126704; 383.062,9.287286616; 383.561,9.3037496432;
            384.062,9.3202126704; 384.562,9.3531387248; 385.062,9.3160969136;
            385.564,9.3942962928; 386.062,9.3531387248; 386.562,9.4025278064;
            387.062,9.4395696176; 387.562,9.4025278064; 388.063,9.4272223472;
            388.563,9.3860647792; 389.063,9.3449072112; 389.562,9.3325599408;
            390.063,9.3366756976; 390.562,9.287286616; 391.064,9.3243284272;
            391.562,9.3119811568; 392.063,9.2132029936; 392.561,9.2008557232;
            393.063,9.2584763184; 393.563,9.20497148; 394.064,9.2420132912;
            394.563,9.2214345072; 395.062,9.20497148; 395.563,9.1967399664;
            396.064,9.225550264; 396.563,9.2008557232; 397.062,9.266707832;
            397.562,9.2955181296; 398.062,9.287286616; 398.564,9.3202126704;
            399.061,9.2996338864; 399.562,9.3037496432; 400.063,9.2708235888;
            400.563,9.2790551024; 401.062,9.2749393456; 401.559,9.2996338864;
            402.063,9.3160969136; 402.561,9.3243284272; 403.062,9.3243284272;
            403.56,9.2378975344; 404.061,9.2749393456; 404.562,9.2708235888;
            405.062,9.2173187504; 405.563,9.2749393456; 406.059,9.2584763184;
            406.562,9.3119811568; 407.062,9.2749393456; 407.559,9.2831708592;
            408.062,9.3160969136; 408.562,9.287286616; 409.062,9.3243284272;
            409.562,9.3243284272; 410.062,9.3778332656; 410.562,9.3654859952;
            411.062,9.3819490224; 411.563,9.3407914544; 412.063,9.3819490224;
            412.563,9.369601752; 413.062,9.3572544816; 413.562,9.3860647792;
            414.062,9.4189908336; 414.562,9.3613702384; 415.061,9.3778332656;
            415.562,9.3531387248; 416.062,9.3737175088; 416.562,9.3449072112;
            417.06,9.390180536; 417.561,9.3325599408; 418.058,9.3243284272;
            418.561,9.3243284272; 419.063,9.266707832; 419.563,9.3160969136;
            420.062,9.3325599408; 420.563,9.3119811568; 421.064,9.3325599408;
            421.563,9.3984120496; 422.06,9.41075932; 422.562,9.3572544816;
            423.059,9.3778332656; 423.562,9.4066435632; 424.064,9.390180536;
            424.562,9.3654859952; 425.062,9.2996338864; 425.563,9.3119811568;
            426.062,9.3078654; 426.562,9.3572544816; 427.06,9.4025278064;
            427.564,9.3654859952; 428.061,9.2955181296; 428.561,9.3325599408;
            429.063,9.3366756976; 429.561,9.3654859952; 430.062,9.3819490224;
            430.561,9.349022968; 431.062,9.3572544816; 431.562,9.3613702384;
            432.058,9.3449072112; 432.564,9.3366756976; 433.064,9.328444184;
            433.563,9.3531387248; 434.062,9.3407914544; 434.563,9.3737175088;
            435.062,9.349022968; 435.563,9.328444184; 436.061,9.369601752;
            436.562,9.2996338864; 437.059,9.3572544816; 437.56,9.3325599408;
            438.193,9.3572544816; 438.559,9.3449072112; 439.062,9.3778332656;
            439.563,9.390180536; 440.074,9.3572544816; 440.561,9.3860647792;
            441.06,9.3778332656; 441.563,9.3613702384; 442.061,9.3366756976;
            442.562,9.3654859952; 443.064,9.3737175088; 443.561,9.3778332656;
            444.064,9.3778332656; 444.563,9.3860647792; 445.075,9.3202126704;
            445.573,9.328444184; 446.063,9.2996338864; 446.582,9.369601752;
            447.061,9.3778332656; 447.564,9.4395696176; 448.064,9.4189908336;
            448.562,9.3984120496; 449.062,9.349022968; 449.559,9.3531387248;
            450.059,9.3531387248; 450.563,9.3202126704; 451.062,9.3449072112;
            451.563,9.2708235888; 452.059,9.3572544816; 452.564,9.3160969136;
            453.06,9.2955181296; 453.561,9.2955181296; 454.06,9.3366756976;
            454.56,9.3325599408; 455.06,9.3572544816; 455.558,9.3572544816;
            456.06,9.4025278064; 456.562,9.3942962928; 457.059,9.390180536;
            457.564,9.4148750768; 458.061,9.472495672; 458.561,9.472495672;
            459.06,9.4683799152; 459.562,9.4560326448; 460.06,9.4889586992;
            460.56,9.451916888; 461.062,9.3819490224; 461.562,9.4272223472;
            462.066,9.287286616; 462.569,9.2996338864; 463.06,9.3160969136;
            463.562,9.2914023728; 464.063,9.3037496432; 464.561,9.3654859952;
            465.06,9.3407914544; 465.563,9.3160969136; 466.06,9.3160969136;
            466.562,9.287286616; 467.061,9.266707832; 467.563,9.2996338864;
            468.062,9.3078654; 468.564,9.3078654; 469.064,9.3819490224; 469.563,
            9.3654859952; 470.063,9.3737175088; 470.562,9.3737175088; 471.062,
            9.4231065904; 471.563,9.4436853744; 472.06,9.431338104; 472.563,
            9.390180536; 473.06,9.4025278064; 473.563,9.3737175088; 474.063,
            9.3613702384; 474.559,9.390180536; 475.062,9.3654859952; 475.563,
            9.4189908336; 476.062,9.369601752; 476.562,9.4148750768; 477.06,
            9.41075932; 477.562,9.41075932; 478.062,9.4066435632; 478.562,
            9.4148750768; 479.061,9.4025278064; 479.562,9.369601752; 480.064,
            9.4066435632; 480.563,9.3984120496; 481.061,9.4189908336; 481.563,
            9.4231065904; 482.061,9.3572544816; 482.563,9.3407914544; 483.062,
            9.3202126704; 483.562,9.3243284272; 484.061,9.3037496432; 484.563,
            9.3366756976; 485.061,9.3654859952; 485.562,9.4148750768; 486.061,
            9.3984120496; 486.561,9.4231065904; 487.062,9.4189908336; 487.562,
            9.4272223472; 488.061,9.4148750768; 488.563,9.41075932; 489.063,
            9.3860647792; 489.563,9.3942962928; 490.062,9.3860647792; 490.563,
            9.4848429424; 491.063,9.4478011312; 491.562,9.4148750768; 492.061,
            9.4436853744; 492.562,9.4066435632; 493.062,9.4272223472; 493.562,
            9.431338104; 494.061,9.431338104; 494.562,9.3819490224; 495.062,
            9.390180536; 495.562,9.3449072112; 496.062,9.349022968; 496.563,
            9.349022968; 497.063,9.3737175088; 497.561,9.3449072112; 498.063,
            9.3613702384; 498.563,9.4066435632; 499.063,9.3860647792; 499.562,
            9.3942962928; 500.062,9.390180536; 500.561,9.3407914544; 501.063,
            9.3531387248; 501.563,9.3160969136; 502.062,9.3366756976; 502.562,
            9.3531387248; 503.061,9.3407914544; 503.563,9.3860647792; 504.063,
            9.3860647792; 504.562,9.4231065904; 505.062,9.3778332656; 505.565,
            9.3860647792; 506.062,9.3613702384; 506.563,9.390180536; 507.06,
            9.4189908336; 507.562,9.349022968; 508.064,9.3778332656; 508.564,
            9.4395696176; 509.061,9.4231065904; 509.562,9.3942962928; 510.059,
            9.369601752; 510.563,9.41075932; 511.062,9.3819490224; 511.56,
            9.3778332656; 512.062,9.431338104; 512.561,9.4189908336; 513.061,
            9.431338104; 513.564,9.4189908336; 514.059,9.4971902128; 514.562,
            9.4601484016; 515.059,9.493074456; 515.564,9.4560326448; 516.064,
            9.328444184; 516.563,9.3449072112; 517.06,9.3366756976; 517.562,
            9.2996338864; 518.062,9.328444184; 518.562,9.3160969136; 519.062,
            9.3737175088; 519.562,9.3160969136; 520.062,9.3202126704; 520.564,
            9.3613702384; 521.062,9.4642641584; 521.563,9.4272223472; 522.061,
            9.431338104; 522.562,9.4395696176; 523.06,9.4766114288; 523.563,
            9.5095374832; 524.063,9.493074456; 524.561,9.4971902128; 525.062,
            9.4683799152; 525.562,9.431338104; 526.062,9.3531387248; 526.561,
            9.3366756976; 527.063,9.2955181296; 527.562,9.3449072112; 528.06,
            9.3737175088; 528.574,9.431338104; 529.061,9.349022968; 529.562,
            9.3984120496; 530.063,9.3778332656; 530.562,9.4189908336; 531.061,
            9.4395696176; 531.562,9.4642641584; 532.064,9.4683799152; 532.561,
            9.4231065904; 533.063,9.4189908336; 533.558,9.4025278064; 534.063,
            9.4272223472; 534.561,9.390180536; 535.061,9.3942962928; 535.563,
            9.3819490224; 536.062,9.390180536; 536.563,9.3449072112; 537.062,
            9.390180536; 537.561,9.3860647792; 538.061,9.3860647792; 538.559,
            9.4148750768; 539.064,9.3984120496; 539.561,9.4189908336; 540.061,
            9.3819490224; 540.562,9.3613702384; 541.063,9.3860647792; 541.563,
            9.390180536; 542.063,9.4231065904; 542.562,9.3778332656; 543.064,
            9.4148750768; 543.561,9.3449072112; 544.063,9.3819490224; 544.561,
            9.4683799152; 545.062,9.431338104; 545.562,9.4436853744; 546.061,
            9.41075932; 546.563,9.4807271856; 547.061,9.41075932; 547.561,
            9.3942962928; 548.062,9.4436853744; 548.562,9.4354538608; 549.062,
            9.4231065904; 549.564,9.4231065904; 550.062,9.41075932; 550.561,
            9.369601752; 551.062,9.369601752; 551.561,9.390180536; 552.063,
            9.3449072112; 552.56,9.4478011312; 553.063,9.4272223472; 553.562,
            9.3942962928; 554.062,9.4642641584; 554.562,9.41075932; 555.062,
            9.3942962928; 555.562,9.390180536; 556.063,9.4231065904; 556.563,
            9.431338104; 557.064,9.472495672; 557.561,9.4601484016; 558.059,
            9.4848429424; 558.563,9.5671580784; 559.06,9.5506950512; 559.563,
            9.5095374832; 560.062,9.4683799152; 560.563,9.3737175088; 561.063,
            9.3572544816; 561.56,9.390180536; 562.177,9.4066435632; 562.563,
            9.3572544816; 563.062,9.349022968; 563.562,9.3737175088; 564.062,
            9.4066435632; 564.562,9.4025278064; 565.062,9.3613702384; 565.563,
            9.4066435632; 566.063,9.3737175088; 566.563,9.4066435632; 567.061,
            9.4066435632; 567.563,9.4272223472; 568.064,9.4066435632; 568.562,
            9.4272223472; 569.063,9.4066435632; 569.563,9.4189908336; 570.062,
            9.4272223472; 570.562,9.3984120496; 571.062,9.4354538608; 571.564,
            9.4354538608; 572.062,9.451916888; 572.563,9.451916888; 573.062,
            9.4395696176; 573.561,9.4395696176; 574.059,9.5054217264; 574.564,
            9.431338104; 575.063,9.4189908336; 575.561,9.3984120496; 576.06,
            9.3860647792; 576.56,9.3613702384; 577.06,9.4889586992; 577.56,
            9.4272223472; 578.058,9.4560326448; 578.56,9.4642641584; 579.06,
            9.4560326448; 579.559,9.3860647792; 580.063,9.349022968; 580.563,
            9.349022968; 581.063,9.3860647792; 581.56,9.3942962928; 582.062,
            9.4807271856; 582.562,9.5095374832; 583.062,9.4766114288; 583.563,
            9.4766114288; 584.061,9.4601484016; 584.562,9.451916888; 585.062,
            9.4354538608; 585.563,9.4478011312; 586.061,9.4766114288; 586.564,
            9.4272223472; 587.062,9.4148750768; 587.561,9.4231065904; 588.061,
            9.4231065904; 588.562,9.4189908336; 589.062,9.4478011312; 589.562,
            9.41075932; 590.063,9.4354538608; 590.563,9.4066435632; 591.063,
            9.3737175088; 591.562,9.4148750768; 592.063,9.3942962928; 592.562,
            9.3819490224; 593.063,9.3860647792; 593.562,9.369601752; 594.063,
            9.4272223472; 594.563,9.431338104; 595.063,9.4395696176; 595.56,
            9.451916888; 596.062,9.4189908336; 596.563,9.4189908336; 597.063,
            9.4066435632; 597.562,9.4560326448; 598.06,9.4395696176; 598.562,
            9.4971902128; 599.063,9.4642641584; 599.562,9.451916888; 600.064,
            9.4189908336; 600.562,9.431338104; 601.062,9.390180536; 601.561,
            9.4560326448; 602.062,9.4025278064; 602.563,9.431338104; 603.062,
            9.4231065904; 603.561,9.4683799152; 604.064,9.4231065904; 604.562,
            9.431338104; 605.061,9.4231065904; 605.564,9.4436853744; 606.063,
            9.4683799152; 606.563,9.4560326448; 607.063,9.4601484016; 607.562,
            9.5177689968; 608.063,9.4189908336; 608.561,9.4189908336; 609.061,
            9.4231065904; 609.564,9.3860647792; 610.062,9.451916888; 610.563,
            9.451916888; 611.062,9.3984120496; 611.562,9.4189908336; 612.062,
            9.390180536; 612.563,9.3737175088; 613.061,9.3572544816; 613.562,
            9.3737175088; 614.064,9.4025278064; 614.563,9.4272223472; 615.062,
            9.4025278064; 615.562,9.4354538608; 616.062,9.41075932; 616.563,
            9.4560326448; 617.063,9.4436853744; 617.564,9.4395696176; 618.061,
            9.5301162672; 618.561,9.493074456; 619.062,9.4683799152; 619.563,
            9.4231065904; 620.063,9.4766114288; 620.56,9.4148750768; 621.063,
            9.4395696176; 621.56,9.4642641584; 622.061,9.390180536; 622.562,
            9.4601484016; 623.06,9.390180536; 623.562,9.4066435632; 624.063,
            9.4560326448; 624.56,9.4478011312; 625.063,9.3819490224; 625.563,
            9.4272223472; 626.064,9.451916888; 626.563,9.4231065904; 627.062,
            9.328444184; 627.563,9.390180536; 628.062,9.4766114288; 628.562,
            9.5177689968; 629.062,9.4642641584; 629.561,9.5424635376; 630.062,
            9.5671580784; 630.563,9.5177689968; 631.062,9.4848429424; 631.561,
            9.575389592; 632.062,9.5054217264; 632.561,9.5795053488; 633.062,
            9.554810808; 633.562,9.472495672; 634.06,9.5013059696; 634.562,
            9.431338104; 635.058,9.4889586992; 635.562,9.4807271856; 636.062,
            9.41075932; 636.559,9.4272223472; 637.06,9.41075932; 637.562,
            9.3654859952; 638.062,9.369601752; 638.562,9.4189908336; 639.063,
            9.4231065904; 639.562,9.4354538608; 640.062,9.4148750768; 640.563,
            9.4642641584; 641.063,9.4642641584; 641.564,9.5177689968; 642.063,
            9.4848429424; 642.562,9.5260005104; 643.06,9.5218847536; 643.562,
            9.5095374832; 644.062,9.4683799152; 644.561,9.4971902128; 645.064,
            9.5054217264; 645.563,9.4889586992; 646.062,9.5383477808; 646.564,
            9.5424635376; 647.063,9.534232024; 647.56,9.5506950512; 648.063,
            9.5877368624; 648.562,9.5260005104; 649.063,9.5013059696; 649.562,
            9.4807271856; 650.063,9.4189908336; 650.559,9.4231065904; 651.062,
            9.3778332656; 651.559,9.369601752; 652.06,9.3819490224; 652.563,
            9.4148750768; 653.062,9.4766114288; 653.564,9.5013059696; 654.062,
            9.5095374832; 654.563,9.5095374832; 655.062,9.5013059696; 655.562,
            9.390180536; 656.06,9.451916888; 656.563,9.390180536; 657.063,
            9.4272223472; 657.561,9.3984120496; 658.062,9.3942962928; 658.559,
            9.3984120496; 659.06,9.4066435632; 659.559,9.4272223472; 660.06,
            9.4560326448; 660.561,9.3819490224; 661.06,9.4560326448; 661.56,
            9.3860647792; 662.059,9.41075932; 662.564,9.4354538608; 663.064,
            9.4066435632; 663.56,9.41075932; 664.063,9.3819490224; 664.562,
            9.4189908336; 665.06,9.4189908336; 665.56,9.390180536; 666.06,
            9.41075932; 666.56,9.369601752; 667.06,9.41075932; 667.56,
            9.4436853744; 668.06,9.4354538608; 668.56,9.4272223472; 669.06,
            9.4189908336; 669.562,9.5054217264; 670.062,9.4272223472; 670.563,
            9.493074456; 671.059,9.4807271856; 671.563,9.451916888; 672.062,
            9.4354538608; 672.559,9.4272223472; 673.06,9.5218847536; 673.56,
            9.4601484016; 674.059,9.51365324; 674.56,9.5054217264; 675.06,
            9.493074456; 675.56,9.4807271856; 676.06,9.4601484016; 676.56,
            9.4436853744; 677.06,9.4766114288; 677.562,9.4766114288; 678.062,
            9.4436853744; 678.563,9.4807271856; 679.064,9.4272223472; 679.562,
            9.5218847536; 680.062,9.5095374832; 680.563,9.493074456; 681.063,
            9.5424635376; 681.559,9.5054217264; 682.062,9.5383477808; 682.561,
            9.4560326448; 683.063,9.41075932; 683.56,9.451916888; 684.063,
            9.3819490224; 684.564,9.4025278064; 685.062,9.4189908336; 685.564,
            9.451916888; 686.062,9.431338104; 686.56,9.4889586992; 687.063,
            9.575389592; 687.561,9.5712738352; 688.06,9.5218847536; 688.561,
            9.5795053488; 689.059,9.5630423216; 689.559,9.5630423216; 690.064,
            9.5630423216; 690.563,9.4889586992; 691.061,9.4642641584; 691.564,
            9.4272223472; 692.059,9.4272223472; 692.561,9.3942962928; 693.06,
            9.4148750768; 693.562,9.5013059696; 694.061,9.4601484016; 694.559,
            9.451916888; 695.06,9.4766114288; 695.56,9.3860647792; 696.062,
            9.4066435632; 696.561,9.3778332656; 697.061,9.3984120496; 697.561,
            9.4189908336; 698.061,9.41075932; 698.559,9.4601484016; 699.062,
            9.4601484016; 699.562,9.4189908336; 700.062,9.3819490224; 700.562,
            9.4025278064; 701.062,9.4066435632; 701.562,9.41075932; 702.062,
            9.4148750768; 702.56,9.4848429424; 703.062,9.4601484016; 703.563,
            9.472495672; 704.063,9.493074456; 704.563,9.554810808; 705.063,
            9.5054217264; 705.562,9.5260005104; 706.063,9.5095374832; 706.563,
            9.4807271856; 707.063,9.5177689968; 707.559,9.5424635376; 708.063,
            9.4766114288; 708.56,9.5260005104; 709.061,9.4642641584; 709.56,
            9.4436853744; 710.059,9.4766114288; 710.56,9.4683799152; 711.059,
            9.4807271856; 711.561,9.4766114288; 712.062,9.4642641584; 712.559,
            9.4807271856; 713.063,9.4601484016; 713.562,9.5054217264; 714.063,
            9.5260005104; 714.563,9.5013059696; 715.062,9.493074456; 715.563,
            9.4601484016; 716.062,9.4560326448; 716.562,9.5013059696; 717.063,
            9.5013059696; 717.559,9.5218847536; 718.063,9.4971902128; 718.562,
            9.51365324; 719.062,9.5589265648; 719.56,9.554810808; 720.06,
            9.5218847536; 720.562,9.5465792944; 721.064,9.4807271856; 721.563,
            9.4354538608; 722.063,9.451916888; 722.559,9.5424635376; 723.062,
            9.4807271856; 723.561,9.5218847536; 724.061,9.4807271856; 724.563,
            9.534232024; 725.062,9.5095374832; 725.562,9.5013059696; 726.061,
            9.4601484016; 726.562,9.5013059696; 727.063,9.4189908336; 727.56,
            9.4642641584; 728.061,9.4478011312; 728.56,9.4148750768; 729.063,
            9.451916888; 729.56,9.5054217264; 730.063,9.493074456; 730.562,
            9.5260005104; 731.063,9.575389592; 731.563,9.4971902128; 732.062,
            9.5054217264; 732.561,9.472495672; 733.062,9.4683799152; 733.562,
            9.4766114288; 734.062,9.4601484016; 734.564,9.472495672; 735.063,
            9.51365324; 735.56,9.5301162672; 736.062,9.4889586992; 736.56,
            9.4848429424; 737.063,9.4683799152; 737.56,9.451916888; 738.062,
            9.4766114288; 738.562,9.493074456; 739.062,9.4807271856; 739.561,
            9.4642641584; 740.062,9.5013059696; 740.562,9.5260005104; 741.062,
            9.5013059696; 741.563,9.4766114288; 742.063,9.472495672; 742.561,
            9.493074456; 743.063,9.5054217264; 743.562,9.5383477808; 744.062,
            9.5260005104; 744.56,9.5260005104; 745.061,9.4971902128; 745.563,
            9.4971902128; 746.061,9.5301162672; 746.562,9.5054217264; 747.061,
            9.4807271856; 747.56,9.493074456; 748.061,9.4766114288; 748.561,
            9.4848429424; 749.061,9.5465792944; 749.562,9.51365324; 750.061,
            9.5177689968; 750.56,9.5383477808; 751.062,9.5177689968; 751.559,
            9.493074456; 752.061,9.4642641584; 752.56,9.4642641584; 753.06,
            9.4560326448; 753.56,9.4436853744; 754.06,9.4436853744; 754.56,
            9.3572544816; 755.06,9.4148750768; 755.559,9.4971902128; 756.06,
            9.4889586992; 756.563,9.4807271856; 757.06,9.5054217264; 757.561,
            9.5177689968; 758.059,9.5177689968; 758.562,9.4848429424; 759.061,
            9.51365324; 759.563,9.5054217264; 760.063,9.5095374832; 760.563,
            9.5013059696; 761.062,9.51365324; 761.563,9.5795053488; 762.063,
            9.5177689968; 762.561,9.554810808; 763.06,9.5260005104; 763.563,
            9.5095374832; 764.063,9.4601484016; 764.562,9.4478011312; 765.063,
            9.3860647792; 765.56,9.3984120496; 766.063,9.349022968; 766.563,
            9.3654859952; 767.063,9.3737175088; 767.562,9.3984120496; 768.062,
            9.41075932; 768.562,9.4354538608; 769.063,9.431338104; 769.562,
            9.431338104; 770.062,9.493074456; 770.56,9.4642641584; 771.061,
            9.5177689968; 771.564,9.451916888; 772.063,9.4478011312; 772.563,
            9.431338104; 773.063,9.4601484016; 773.563,9.4436853744; 774.062,
            9.4436853744; 774.562,9.4231065904; 775.063,9.4436853744; 775.561,
            9.4272223472; 776.063,9.4354538608; 776.562,9.4395696176; 777.061,
            9.4066435632; 777.562,9.4272223472; 778.064,9.4231065904; 778.561,
            9.3654859952; 779.063,9.451916888; 779.567,9.3984120496; 780.063,
            9.4436853744; 780.562,9.4683799152; 781.063,9.5218847536; 781.562,
            9.6124314032; 782.062,9.6247786736; 782.564,9.5795053488; 783.063,
            9.5712738352; 783.563,9.5836211056; 784.065,9.5013059696; 784.563,
            9.5095374832; 785.063,9.5260005104; 785.562,9.5013059696; 786.063,
            9.472495672; 786.563,9.472495672; 787.062,9.4478011312; 787.563,
            9.4354538608; 788.062,9.4189908336; 788.561,9.4560326448; 789.06,
            9.4683799152; 789.56,9.4354538608; 790.062,9.4436853744; 790.561,
            9.4354538608; 791.06,9.4683799152; 791.56,9.4560326448; 792.059,
            9.4848429424; 792.56,9.4601484016; 793.059,9.4560326448; 793.562,
            9.4807271856; 794.061,9.51365324; 794.56,9.5260005104; 795.061,
            9.4601484016; 795.561,9.5013059696; 796.061,9.51365324; 796.56,
            9.4971902128; 797.062,9.5013059696; 797.561,9.5301162672; 798.061,
            9.451916888; 798.561,9.4971902128; 799.062,9.4807271856; 799.56,
            9.4807271856; 800.061,9.4848429424; 800.561,9.4395696176; 801.061,
            9.4189908336; 801.561,9.4231065904; 802.062,9.4683799152; 802.56,
            9.5095374832; 803.059,9.5013059696; 803.56,9.51365324; 804.061,
            9.4848429424; 804.561,9.4889586992; 805.061,9.5054217264; 805.561,
            9.4848429424; 806.061,9.4848429424; 806.561,9.4478011312; 807.061,
            9.4766114288; 807.561,9.4683799152; 808.06,9.472495672; 808.562,
            9.4766114288; 809.062,9.4683799152; 809.561,9.4436853744; 810.061,
            9.4642641584; 810.562,9.4642641584; 811.06,9.4189908336; 811.56,
            9.3819490224; 812.063,9.4066435632; 812.561,9.3860647792; 813.061,
            9.41075932; 813.562,9.3449072112; 814.062,9.431338104; 814.56,
            9.4395696176; 815.06,9.4272223472; 815.56,9.4560326448; 816.062,
            9.4766114288; 816.563,9.472495672; 817.06,9.5054217264; 817.56,
            9.5260005104; 818.06,9.4683799152; 818.56,9.5424635376; 819.061,
            9.5465792944; 819.56,9.5424635376; 820.06,9.472495672; 820.561,
            9.4848429424; 821.061,9.4971902128; 821.56,9.4971902128; 822.061,
            9.4601484016; 822.561,9.5013059696; 823.061,9.451916888; 823.56,
            9.5013059696; 824.061,9.4971902128; 824.56,9.493074456; 825.059,
            9.4889586992; 825.56,9.4066435632; 826.06,9.4601484016; 826.56,
            9.431338104; 827.061,9.493074456; 827.561,9.4889586992; 828.06,
            9.451916888; 828.561,9.4395696176; 829.06,9.4272223472; 829.562,
            9.4478011312; 830.061,9.472495672; 830.561,9.4642641584; 831.06,
            9.472495672; 831.56,9.4354538608; 832.061,9.4272223472; 832.56,
            9.4395696176; 833.063,9.4560326448; 833.56,9.4560326448; 834.061,
            9.4807271856; 834.561,9.4478011312; 835.063,9.4560326448; 835.56,
            9.4395696176; 836.061,9.4601484016; 836.561,9.4560326448; 837.06,
            9.451916888; 837.563,9.4560326448; 838.062,9.472495672; 838.561,
            9.3942962928; 839.062,9.4148750768; 839.561,9.3572544816; 840.063,
            9.369601752; 840.559,9.3778332656; 841.061,9.369601752; 841.562,
            9.349022968; 842.064,9.3860647792; 842.561,9.4231065904; 843.061,
            9.3737175088; 843.564,9.4436853744; 844.063,9.4066435632; 844.563,
            9.4272223472; 845.062,9.3860647792; 845.56,9.4560326448; 846.064,
            9.472495672; 846.562,9.472495672; 847.064,9.4560326448; 847.56,
            9.431338104; 848.064,9.451916888; 848.563,9.4189908336; 849.063,
            9.4807271856; 849.563,9.4642641584; 850.06,9.4560326448; 850.562,
            9.4766114288; 851.062,9.4478011312; 851.563,9.3984120496; 852.063,
            9.3819490224; 852.561,9.3942962928; 853.061,9.4231065904; 853.564,
            9.3984120496; 854.064,9.4478011312; 854.562,9.4354538608; 855.062,
            9.472495672; 855.564,9.4436853744; 856.061,9.4189908336; 856.563,
            9.4807271856; 857.063,9.4395696176; 857.564,9.4848429424; 858.064,
            9.4354538608; 858.561,9.4889586992; 859.063,9.4272223472; 859.562,
            9.4560326448; 860.063,9.4189908336; 860.563,9.4231065904; 861.06,
            9.3778332656; 861.562,9.4231065904; 862.065,9.4601484016; 862.564,
            9.4478011312; 863.061,9.4889586992; 863.563,9.4395696176; 864.063,
            9.431338104; 864.561,9.4354538608; 865.062,9.4148750768; 865.564,
            9.4354538608; 866.063,9.4025278064; 866.561,9.3984120496; 867.062,
            9.41075932; 867.563,9.3942962928; 868.062,9.4272223472; 868.562,
            9.4436853744; 869.063,9.4766114288; 869.562,9.4478011312; 870.063,
            9.4889586992; 870.56,9.5095374832; 871.064,9.5301162672; 871.564,
            9.4395696176; 872.062,9.4272223472; 872.562,9.41075932; 873.063,
            9.390180536; 873.562,9.4354538608; 874.062,9.4683799152; 874.56,
            9.4601484016; 875.064,9.4642641584; 875.562,9.51365324; 876.064,
            9.4807271856; 876.563,9.4971902128; 877.063,9.5465792944; 877.562,
            9.5013059696; 878.063,9.4971902128; 878.564,9.5836211056; 879.062,
            9.5095374832; 879.563,9.554810808; 880.063,9.4889586992; 880.564,
            9.5424635376; 881.061,9.5630423216; 881.563,9.5095374832; 882.063,
            9.5424635376; 882.564,9.5589265648; 883.063,9.5795053488; 883.562,
            9.575389592; 884.065,9.5260005104; 884.563,9.5301162672; 885.063,
            9.5383477808; 885.564,9.5506950512; 886.064,9.5671580784; 886.562,
            9.595968376; 887.063,9.6247786736; 887.564,9.5877368624; 888.062,
            9.5424635376; 888.563,9.5465792944; 889.063,9.5424635376; 889.564,
            9.5465792944; 890.063,9.5383477808; 890.562,9.51365324; 891.062,
            9.5424635376; 891.563,9.5671580784; 892.063,9.5795053488; 892.564,
            9.595968376; 893.063,9.5424635376; 893.564,9.5712738352; 894.063,
            9.5671580784; 894.563,9.6000841328; 895.062,9.5671580784; 895.565,
            9.5465792944; 896.062,9.5260005104; 896.563,9.5301162672; 897.063,
            9.5630423216; 897.565,9.5424635376; 898.062,9.5177689968; 898.563,
            9.5260005104; 899.064,9.4971902128; 899.563,9.4848429424; 900.063,
            9.5095374832; 900.563,9.4971902128; 901.063,9.51365324; 901.564,
            9.5260005104; 902.065,9.5424635376; 902.562,9.5383477808; 903.063,
            9.4272223472; 903.564,9.4436853744; 904.063,9.5260005104; 904.563,
            9.4601484016; 905.063,9.431338104; 905.562,9.4971902128; 906.063,
            9.451916888; 906.562,9.4971902128; 907.062,9.5260005104; 907.564,
            9.4889586992; 908.064,9.5301162672; 908.564,9.4971902128; 909.062,
            9.51365324; 909.563,9.5177689968; 910.062,9.51365324; 910.56,
            9.4971902128; 911.063,9.554810808; 911.563,9.5465792944; 912.064,
            9.534232024; 912.562,9.5095374832; 913.063,9.534232024; 913.563,
            9.5671580784; 914.063,9.5506950512; 914.564,9.5424635376; 915.064,
            9.5218847536; 915.563,9.5506950512; 916.063,9.6083156464; 916.564,
            9.554810808; 917.063,9.5918526192; 917.565,9.5795053488; 918.063,
            9.5465792944; 918.564,9.534232024; 919.065,9.493074456; 919.564,
            9.5383477808; 920.065,9.5506950512; 920.562,9.5918526192; 921.063,
            9.5177689968; 921.565,9.5712738352; 922.063,9.6041998896; 922.564,
            9.5836211056; 923.065,9.5795053488; 923.562,9.575389592; 924.062,
            9.5506950512; 924.564,9.5918526192; 925.061,9.6124314032; 925.562,
            9.6083156464; 926.062,9.6330101872; 926.559,9.6535889712; 927.063,
            9.6741677552; 927.565,9.6453574576; 928.063,9.61654716; 928.563,
            9.61654716; 929.064,9.6124314032; 929.563,9.6083156464; 930.064,
            9.7070938096; 930.564,9.678283512; 931.064,9.6247786736; 931.563,
            9.5795053488; 932.064,9.5424635376; 932.563,9.5877368624; 933.064,
            9.6000841328; 933.564,9.595968376; 934.062,9.6124314032; 934.563,
            9.6124314032; 935.063,9.6494732144; 935.562,9.6000841328; 936.063,
            9.5506950512; 936.56,9.5506950512; 937.06,9.554810808; 937.563,
            9.5383477808; 938.063,9.5712738352; 938.563,9.5589265648; 939.065,
            9.61654716; 939.565,9.5589265648; 940.064,9.5301162672; 940.563,
            9.554810808; 941.065,9.5589265648; 941.562,9.5795053488; 942.065,
            9.5465792944; 942.562,9.5918526192; 943.063,9.6041998896; 943.563,
            9.5506950512; 944.063,9.595968376; 944.565,9.5465792944; 945.063,
            9.5630423216; 945.563,9.5301162672; 946.064,9.534232024; 946.563,
            9.5301162672; 947.062,9.575389592; 947.565,9.5630423216; 948.063,
            9.5630423216; 948.564,9.5712738352; 949.065,9.5589265648; 949.564,
            9.5671580784; 950.06,9.5465792944; 950.564,9.5589265648; 951.065,
            9.5918526192; 951.56,9.5630423216; 952.06,9.6124314032; 952.563,
            9.575389592; 953.062,9.5712738352; 953.563,9.5877368624; 954.064,
            9.5301162672; 954.563,9.4683799152; 955.062,9.5095374832; 955.563,
            9.4272223472; 956.063,9.51365324; 956.561,9.5383477808; 957.063,
            9.493074456; 957.563,9.534232024; 958.062,9.5630423216; 958.564,
            9.5671580784; 959.064,9.595968376; 959.563,9.5836211056; 960.063,
            9.6412417008; 960.562,9.5424635376; 961.062,9.6041998896; 961.563,
            9.5877368624; 962.061,9.595968376; 962.561,9.6000841328; 963.064,
            9.6041998896; 963.562,9.6206629168; 964.062,9.5877368624; 964.564,
            9.637125944; 965.063,9.575389592; 965.561,9.4642641584; 966.064,
            9.493074456; 966.562,9.5177689968; 967.063,9.554810808; 967.565,
            9.6947465392; 968.062,9.7441356208; 968.563,9.7359041072; 969.061,
            9.7112095664; 969.563,9.7359041072; 970.063,9.7070938096; 970.564,
            9.698862296; 971.064,9.6494732144; 971.563,9.7153253232; 972.063,
            9.7317883504; 972.563,9.7070938096; 973.061,9.7070938096; 973.563,
            9.6412417008; 974.063,9.5465792944; 974.564,9.6124314032; 975.063,
            9.6535889712; 975.563,9.6412417008; 976.063,9.6535889712; 976.562,
            9.657704728; 977.064,9.5506950512; 977.563,9.595968376; 978.064,
            9.6247786736; 978.563,9.595968376; 979.065,9.5630423216; 979.563,
            9.5671580784; 980.064,9.6041998896; 980.564,9.6000841328; 981.061,
            9.5506950512; 981.563,9.5013059696; 982.063,9.5506950512; 982.563,
            9.575389592; 983.063,9.4848429424; 983.564,9.5301162672; 984.064,
            9.5712738352; 984.564,9.5506950512; 985.065,9.5712738352; 985.562,
            9.554810808; 986.063,9.6041998896; 986.565,9.5589265648; 987.064,
            9.5506950512; 987.563,9.6247786736; 988.062,9.5877368624; 988.564,
            9.6412417008; 989.064,9.5877368624; 989.564,9.5506950512; 990.064,
            9.5260005104; 990.563,9.6247786736; 991.064,9.5260005104; 991.56,
            9.6000841328; 992.063,9.6288944304; 992.563,9.6247786736; 993.064,
            9.5465792944; 993.563,9.5836211056; 994.062,9.5506950512; 994.564,
            9.6000841328; 995.063,9.5424635376; 995.563,9.5589265648; 996.062,
            9.5712738352; 996.563,9.6247786736; 997.064,9.5301162672; 997.564,
            9.575389592; 998.063,9.6330101872; 998.563,9.6247786736; 999.062,
            9.6659362416; 999.564,9.6494732144; 1000.065,9.6494732144; 1000.564,
            9.6535889712; 1001.063,9.6330101872; 1001.565,9.657704728; 1002.064,
            9.5836211056; 1002.565,9.6247786736; 1003.062,9.6823992688;
            1003.564,9.6823992688; 1004.063,9.7317883504; 1004.564,9.6247786736;
            1005.063,9.657704728; 1005.564,9.7029780528; 1006.062,9.6000841328;
            1006.564,9.6124314032; 1007.063,9.6124314032; 1007.562,9.575389592;
            1008.061,9.5836211056; 1008.565,9.61654716; 1009.063,9.5795053488;
            1009.564,9.6453574576; 1010.063,9.5260005104; 1010.563,9.595968376;
            1011.063,9.5877368624; 1011.562,9.5630423216; 1012.063,9.5589265648;
            1012.564,9.6083156464; 1013.062,9.6124314032; 1013.562,9.6700519984;
            1014.063,9.6741677552; 1014.564,9.5630423216; 1015.063,9.6083156464;
            1015.563,9.6535889712; 1016.064,9.6330101872; 1016.563,9.637125944;
            1017.063,9.6494732144; 1017.562,9.6206629168; 1018.06,9.6288944304;
            1018.563,9.575389592; 1019.063,9.61654716; 1019.563,9.575389592;
            1020.064,9.6000841328; 1020.564,9.595968376; 1021.063,9.61654716;
            1021.563,9.6206629168; 1022.062,9.575389592; 1022.562,9.5424635376;
            1023.06,9.5383477808; 1023.564,9.5671580784; 1024.065,9.595968376;
            1024.563,9.6700519984; 1025.064,9.698862296; 1025.563,9.6823992688;
            1026.064,9.6659362416; 1026.565,9.6741677552; 1027.063,9.6124314032;
            1027.565,9.6247786736; 1028.06,9.6000841328; 1028.564,9.5836211056;
            1029.062,9.6288944304; 1029.564,9.657704728; 1030.064,9.5877368624;
            1030.564,9.6206629168; 1031.064,9.595968376; 1031.564,9.554810808;
            1032.063,9.6041998896; 1032.564,9.5795053488; 1033.06,9.6453574576;
            1033.563,9.6288944304; 1034.063,9.6453574576; 1034.564,9.6412417008;
            1035.064,9.6618204848; 1035.562,9.6206629168; 1036.064,9.6700519984;
            1036.564,9.6865150256; 1037.062,9.71944108; 1037.564,9.6494732144;
            1038.062,9.6906307824; 1038.563,9.6618204848; 1039.063,9.657704728;
            1039.563,9.6453574576; 1040.063,9.637125944; 1040.564,9.5671580784;
            1041.066,9.5836211056; 1041.562,9.5465792944; 1042.063,9.5054217264;
            1042.562,9.6041998896; 1043.064,9.5301162672; 1043.563,9.6288944304;
            1044.063,9.5671580784; 1044.561,9.6041998896; 1045.063,9.5877368624;
            1045.563,9.6494732144; 1046.064,9.5918526192; 1046.562,9.61654716;
            1047.063,9.6124314032; 1047.563,9.5671580784; 1048.062,9.6083156464;
            1048.562,9.6124314032; 1049.064,9.6247786736; 1049.563,9.5795053488;
            1050.062,9.575389592; 1050.563,9.575389592; 1051.063,9.5506950512;
            1051.564,9.6000841328; 1052.063,9.5630423216; 1052.563,9.575389592;
            1053.062,9.5877368624; 1053.563,9.5836211056; 1054.061,9.6206629168;
            1054.563,9.5877368624; 1055.064,9.6288944304; 1055.564,9.637125944;
            1056.064,9.6494732144; 1056.564,9.61654716; 1057.063,9.6659362416;
            1057.565,9.637125944; 1058.063,9.6535889712; 1058.565,9.6906307824;
            1059.064,9.6741677552; 1059.565,9.6659362416; 1060.062,9.6823992688;
            1060.563,9.7070938096; 1061.064,9.6823992688; 1061.563,9.678283512;
            1062.063,9.71944108; 1062.563,9.698862296; 1063.065,9.6741677552;
            1063.562,9.7359041072; 1064.063,9.678283512; 1064.564,9.6618204848;
            1065.063,9.6453574576; 1065.564,9.6330101872; 1066.064,9.6453574576;
            1066.565,9.6041998896; 1067.064,9.6206629168; 1067.565,9.61654716;
            1068.064,9.637125944; 1068.564,9.6494732144; 1069.064,9.6412417008;
            1069.564,9.6659362416; 1070.064,9.7276725936; 1070.564,9.6906307824;
            1071.064,9.7029780528; 1071.562,9.6412417008; 1072.063,9.6865150256;
            1072.565,9.6947465392; 1073.064,9.7317883504; 1073.564,9.6823992688;
            1074.063,9.7112095664; 1074.564,9.678283512; 1075.062,9.698862296;
            1075.562,9.7070938096; 1076.063,9.7482513776; 1076.562,9.7235568368;
            1077.064,9.7564828912; 1077.562,9.7647144048; 1078.063,9.7976404592;
            1078.562,9.781177432; 1079.064,9.7852931888; 1079.564,9.7935247024;
            1080.064,9.7770616752; 1080.562,9.7482513776; 1081.064,9.7317883504;
            1081.56,9.7647144048; 1082.064,9.7276725936; 1082.565,9.7153253232;
            1083.064,9.678283512; 1083.563,9.6412417008; 1084.064,9.6288944304;
            1084.562,9.6412417008; 1085.064,9.678283512; 1085.564,9.6659362416;
            1086.064,9.6535889712; 1086.564,9.6453574576; 1087.062,9.6494732144;
            1087.563,9.6247786736; 1088.062,9.6330101872; 1088.563,9.6494732144;
            1089.064,9.6947465392; 1089.562,9.7029780528; 1090.063,9.7235568368;
            1090.564,9.7112095664; 1091.065,9.698862296; 1091.561,9.6947465392;
            1092.063,9.6823992688; 1092.563,9.740019864; 1093.064,9.7112095664;
            1093.564,9.7317883504; 1094.064,9.7647144048; 1094.563,9.7688301616;
            1095.063,9.6947465392; 1095.563,9.6412417008; 1096.065,9.6618204848;
            1096.564,9.595968376; 1097.063,9.5795053488; 1097.564,9.6206629168;
            1098.062,9.6206629168; 1098.563,9.657704728; 1099.063,9.595968376;
            1099.563,9.6412417008; 1100.064,9.698862296; 1100.563,9.6947465392;
            1101.064,9.7317883504; 1101.564,9.7276725936; 1102.063,9.7029780528;
            1102.563,9.6700519984; 1103.063,9.678283512; 1103.565,9.6823992688;
            1104.064,9.6947465392; 1104.564,9.7482513776; 1105.065,9.7359041072;
            1105.562,9.7112095664; 1106.064,9.7317883504; 1106.563,9.740019864;
            1107.063,9.7729459184; 1107.561,9.7564828912; 1108.062,9.7070938096;
            1108.563,9.6618204848; 1109.061,9.7276725936; 1109.563,9.678283512;
            1110.063,9.698862296; 1110.562,9.71944108; 1111.061,9.6947465392;
            1111.56,9.7482513776; 1112.059,9.7112095664; 1112.561,9.7770616752;
            1113.06,9.7029780528; 1113.561,9.7441356208; 1114.062,9.6823992688;
            1114.56,9.7112095664; 1115.061,9.7070938096; 1115.561,9.740019864;
            1116.061,9.7070938096; 1116.562,9.7070938096; 1117.061,9.7441356208;
            1117.563,9.7359041072; 1118.063,9.6823992688; 1118.563,9.698862296;
            1119.064,9.6659362416; 1119.563,9.6618204848; 1120.063,9.637125944;
            1120.563,9.61654716; 1121.063,9.6206629168; 1121.563,9.5836211056;
            1122.063,9.61654716; 1122.565,9.6000841328; 1123.064,9.6535889712;
            1123.56,9.6494732144; 1124.063,9.6330101872; 1124.564,9.5877368624;
            1125.064,9.6083156464; 1125.564,9.6412417008; 1126.063,9.6618204848;
            1126.563,9.637125944; 1127.064,9.657704728; 1127.564,9.657704728;
            1128.064,9.6659362416; 1128.564,9.6288944304; 1129.063,9.61654716;
            1129.565,9.6206629168; 1130.064,9.6453574576; 1130.564,9.595968376;
            1131.064,9.595968376; 1131.565,9.6412417008; 1132.064,9.6000841328;
            1132.564,9.575389592; 1133.065,9.6083156464; 1133.562,9.637125944;
            1134.064,9.6906307824; 1134.563,9.7070938096; 1135.065,9.7112095664;
            1135.564,9.7070938096; 1136.064,9.7235568368; 1136.563,9.7070938096;
            1137.065,9.7153253232; 1137.565,9.698862296; 1138.064,9.6247786736;
            1138.562,9.6206629168; 1139.061,9.6041998896; 1139.564,9.6124314032;
            1140.063,9.61654716; 1140.564,9.657704728; 1141.064,9.6741677552;
            1141.564,9.6659362416; 1142.065,9.6865150256; 1142.563,9.637125944;
            1143.064,9.6823992688; 1143.564,9.6659362416; 1144.064,9.637125944;
            1144.563,9.6659362416; 1145.064,9.6535889712; 1145.563,9.657704728;
            1146.063,9.6741677552; 1146.565,9.6659362416; 1147.063,9.6535889712;
            1147.564,9.6741677552; 1148.063,9.6659362416; 1148.563,9.7029780528;
            1149.062,9.6700519984; 1149.563,9.7153253232; 1150.064,9.7153253232;
            1150.564,9.6823992688; 1151.063,9.6659362416; 1151.564,9.6700519984;
            1152.062,9.6618204848; 1152.565,9.6947465392; 1153.063,9.6865150256;
            1153.563,9.71944108; 1154.063,9.7112095664; 1154.564,9.678283512;
            1155.065,9.6906307824; 1155.564,9.6906307824; 1156.062,9.7276725936;
            1156.564,9.7112095664; 1157.065,9.7029780528; 1157.563,9.6741677552;
            1158.063,9.7029780528; 1158.563,9.7070938096; 1159.063,9.7523671344;
            1159.564,9.6906307824; 1160.063,9.6700519984; 1160.564,9.698862296;
            1161.065,9.7112095664; 1161.564,9.6865150256; 1162.062,9.6823992688;
            1162.564,9.7153253232; 1163.063,9.7317883504; 1163.563,9.678283512;
            1164.063,9.6906307824; 1164.564,9.657704728; 1165.063,9.6330101872;
            1165.562,9.6412417008; 1166.064,9.6247786736; 1166.56,9.657704728;
            1167.064,9.6535889712; 1167.56,9.7441356208; 1168.064,9.781177432;
            1168.563,9.7647144048; 1169.065,9.7564828912; 1169.563,9.7729459184;
            1170.062,9.7359041072; 1170.563,9.760598648; 1171.063,9.7523671344;
            1171.563,9.7235568368; 1172.062,9.6947465392; 1172.563,9.7276725936;
            1173.064,9.7235568368; 1173.564,9.6947465392; 1174.061,9.6659362416;
            1174.564,9.6865150256; 1175.065,9.6865150256; 1175.563,9.6906307824;
            1176.065,9.7688301616; 1176.564,9.7112095664; 1177.064,9.7770616752;
            1177.563,9.7482513776; 1178.063,9.7359041072; 1178.562,9.7523671344;
            1179.064,9.7523671344; 1179.563,9.7564828912; 1180.063,9.7729459184;
            1180.564,9.7276725936; 1181.065,9.698862296; 1181.563,9.6412417008;
            1182.064,9.657704728; 1182.563,9.698862296; 1183.064,9.7112095664;
            1183.563,9.678283512; 1184.06,9.6865150256; 1184.562,9.6700519984;
            1185.063,9.698862296; 1185.561,9.71944108; 1186.062,9.7112095664;
            1186.561,9.6865150256; 1187.064,9.6741677552; 1187.563,9.7688301616;
            1188.063,9.7317883504; 1188.563,9.760598648; 1189.064,9.7976404592;
            1189.563,9.781177432; 1190.064,9.7770616752; 1190.564,9.7688301616;
            1191.063,9.8141034864; 1191.563,9.7359041072; 1192.064,9.8099877296;
            1192.563,9.7729459184; 1193.065,9.8099877296; 1193.564,9.7976404592;
            1194.063,9.8058719728; 1194.564,9.7482513776; 1195.063,9.71944108;
            1195.562,9.698862296; 1196.064,9.7359041072; 1196.564,9.7317883504;
            1197.063,9.71944108; 1197.564,9.6865150256; 1198.064,9.7235568368;
            1198.563,9.657704728; 1199.065,9.6206629168; 1199.563,9.6618204848;
            1200.064,9.61654716; 1200.562,9.6412417008; 1201.064,9.6041998896;
            1201.564,9.6083156464; 1202.063,9.595968376; 1202.562,9.6000841328;
            1203.063,9.5836211056; 1203.563,9.595968376; 1204.062,9.6041998896;
            1204.565,9.6330101872; 1205.064,9.6947465392; 1205.564,9.6823992688;
            1206.063,9.7153253232; 1206.563,9.7153253232; 1207.063,9.6906307824;
            1207.563,9.6906307824; 1208.064,9.7276725936; 1208.563,9.71944108;
            1209.061,9.6823992688; 1209.564,9.6741677552; 1210.062,9.698862296;
            1210.56,9.6823992688; 1211.062,9.6700519984; 1211.562,9.6947465392;
            1212.062,9.6247786736; 1212.564,9.6330101872; 1213.062,9.6412417008;
            1213.564,9.637125944; 1214.064,9.6453574576; 1214.56,9.6700519984;
            1215.064,9.698862296; 1215.562,9.678283512; 1216.061,9.6741677552;
            1216.564,9.7276725936; 1217.065,9.6494732144; 1217.564,9.7112095664;
            1218.063,9.6618204848; 1218.564,9.698862296; 1219.063,9.7029780528;
            1219.563,9.7359041072; 1220.063,9.760598648; 1220.564,9.7729459184;
            1221.063,9.7235568368; 1221.562,9.781177432; 1222.063,9.7235568368;
            1222.562,9.7894089456; 1223.065,9.8058719728; 1223.562,9.7153253232;
            1224.064,9.6700519984; 1224.564,9.6659362416; 1225.064,9.6741677552;
            1225.564,9.6618204848; 1226.064,9.6865150256; 1226.562,9.6906307824;
            1227.062,9.6659362416; 1227.564,9.6535889712; 1228.063,9.7112095664;
            1228.561,9.6906307824; 1229.064,9.7153253232; 1229.565,9.7153253232;
            1230.064,9.7153253232; 1230.564,9.7112095664; 1231.064,9.7647144048;
            1231.564,9.71944108; 1232.063,9.781177432; 1232.564,9.7482513776;
            1233.064,9.7564828912; 1233.562,9.6865150256; 1234.062,9.6741677552;
            1234.566,9.6659362416; 1235.065,9.6535889712; 1235.564,9.6288944304;
            1236.065,9.575389592; 1236.563,9.6659362416; 1237.064,9.6618204848;
            1237.564,9.6865150256; 1238.063,9.7482513776; 1238.563,9.760598648;
            1239.064,9.7976404592; 1239.562,9.7770616752; 1240.064,9.7647144048;
            1240.564,9.7359041072; 1241.064,9.7770616752; 1241.564,9.7482513776;
            1242.063,9.7276725936; 1242.561,9.7070938096; 1243.063,9.740019864;
            1243.564,9.7029780528; 1244.063,9.71944108; 1244.565,9.7482513776;
            1245.064,9.7935247024; 1245.563,9.801756216; 1246.064,9.8387980272;
            1246.563,9.801756216; 1247.062,9.8346822704; 1247.564,9.7688301616;
            1248.065,9.7523671344; 1248.56,9.8141034864; 1249.065,9.7523671344;
            1249.563,9.7564828912; 1250.065,9.698862296; 1250.565,9.781177432;
            1251.062,9.7317883504; 1251.564,9.7647144048; 1252.065,9.7276725936;
            1252.562,9.7317883504; 1253.064,9.7029780528; 1253.563,9.7153253232;
            1254.064,9.6618204848; 1254.563,9.6947465392; 1255.065,9.740019864;
            1255.564,9.760598648; 1256.064,9.6906307824; 1256.563,9.7359041072;
            1257.063,9.7359041072; 1257.564,9.7112095664; 1258.064,9.7153253232;
            1258.562,9.7482513776; 1259.062,9.7153253232; 1259.566,9.7153253232;
            1260.064,9.7029780528; 1260.562,9.6659362416; 1261.063,9.6865150256;
            1261.564,9.6124314032; 1262.063,9.6453574576; 1262.563,9.6288944304;
            1263.063,9.61654716; 1263.562,9.6288944304; 1264.059,9.678283512;
            1264.561,9.6906307824; 1265.064,9.6906307824; 1265.564,9.6700519984;
            1266.063,9.7235568368; 1266.564,9.6412417008; 1267.063,9.657704728;
            1267.564,9.6700519984; 1268.063,9.7112095664; 1268.561,9.7317883504;
            1269.063,9.7153253232; 1269.564,9.760598648; 1270.065,9.6823992688;
            1270.563,9.7523671344; 1271.064,9.7359041072; 1271.563,9.760598648;
            1272.063,9.8058719728; 1272.563,9.7770616752; 1273.064,9.7482513776;
            1273.561,9.7894089456; 1274.063,9.7852931888; 1274.562,9.740019864;
            1275.063,9.7647144048; 1275.56,9.7359041072; 1276.064,9.781177432;
            1276.563,9.7482513776; 1277.063,9.7029780528; 1277.564,9.6906307824;
            1278.064,9.6906307824; 1278.561,9.6865150256; 1279.063,9.6906307824;
            1279.564,9.6947465392; 1280.063,9.6947465392; 1280.565,9.7112095664;
            1281.064,9.7359041072; 1281.563,9.7317883504; 1282.063,9.71944108;
            1282.562,9.6823992688; 1283.061,9.7070938096; 1283.561,9.7112095664;
            1284.064,9.7441356208; 1284.562,9.7235568368; 1285.064,9.7317883504;
            1285.563,9.71944108; 1286.065,9.7441356208; 1286.564,9.7276725936;
            1287.064,9.7647144048; 1287.564,9.6700519984; 1288.063,9.7482513776;
            1288.561,9.7647144048; 1289.063,9.6700519984; 1289.564,9.7359041072;
            1290.064,9.7070938096; 1290.563,9.7317883504; 1291.064,9.7523671344;
            1291.565,9.7359041072; 1292.064,9.6906307824; 1292.564,9.6906307824;
            1293.064,9.7359041072; 1293.562,9.7070938096; 1294.061,9.7441356208;
            1294.562,9.7852931888; 1295.065,9.781177432; 1295.563,9.7647144048;
            1296.061,9.7112095664; 1296.564,9.6823992688; 1297.064,9.7441356208;
            1297.563,9.7276725936; 1298.064,9.7564828912; 1298.565,9.7441356208;
            1299.064,9.7688301616; 1299.565,9.7112095664; 1300.061,9.740019864;
            1300.564,9.6659362416; 1301.064,9.6494732144; 1301.563,9.6453574576;
            1302.064,9.6124314032; 1302.564,9.6000841328; 1303.063,9.657704728;
            1303.564,9.678283512; 1304.064,9.7153253232; 1304.564,9.698862296;
            1305.063,9.7317883504; 1305.564,9.7153253232; 1306.065,9.698862296;
            1306.564,9.7153253232; 1307.064,9.7441356208; 1307.563,9.7523671344;
            1308.063,9.7688301616; 1308.563,9.7276725936; 1309.065,9.740019864;
            1309.563,9.6865150256; 1310.065,9.6823992688; 1310.563,9.7235568368;
            1311.066,9.6453574576; 1311.564,9.7029780528; 1312.065,9.71944108;
            1312.562,9.7235568368; 1313.064,9.7729459184; 1313.56,9.760598648;
            1314.065,9.7523671344; 1314.565,9.7070938096; 1315.063,9.6947465392;
            1315.564,9.6247786736; 1316.062,9.6535889712; 1316.564,9.698862296;
            1317.061,9.71944108; 1317.563,9.7317883504; 1318.064,9.6947465392;
            1318.563,9.7235568368; 1319.063,9.7688301616; 1319.563,9.7688301616;
            1320.063,9.7482513776; 1320.562,9.7482513776; 1321.064,9.7276725936;
            1321.565,9.7153253232; 1322.063,9.760598648; 1322.561,9.740019864;
            1323.063,9.7359041072; 1323.563,9.7564828912; 1324.064,9.6906307824;
            1324.561,9.657704728; 1325.063,9.5877368624; 1325.565,9.6453574576;
            1326.062,9.7070938096; 1326.564,9.6906307824; 1327.07,9.7112095664;
            1327.564,9.7276725936; 1328.064,9.7441356208; 1328.564,9.740019864;
            1329.062,9.7729459184; 1329.565,9.7564828912; 1330.063,9.8141034864;
            1330.563,9.781177432; 1331.063,9.7976404592; 1331.566,9.7770616752;
            1332.063,9.760598648; 1332.561,9.781177432; 1333.062,9.8264507568;
            1333.563,9.8346822704; 1334.064,9.8141034864; 1334.564,9.7688301616;
            1335.063,9.7852931888; 1335.564,9.7852931888; 1336.063,9.7935247024;
            1336.564,9.8141034864; 1337.063,9.7976404592; 1337.564,9.8305665136;
            1338.064,9.801756216; 1338.564,9.7770616752; 1339.063,9.7276725936;
            1339.563,9.6906307824; 1340.064,9.7235568368; 1340.563,9.6947465392;
            1341.064,9.7235568368; 1341.563,9.7112095664; 1342.064,9.7153253232;
            1342.562,9.6906307824; 1343.064,9.7523671344; 1343.563,9.7852931888;
            1344.064,9.801756216; 1344.563,9.7564828912; 1345.064,9.8305665136;
            1345.564,9.760598648; 1346.063,9.8182192432; 1346.564,9.8099877296;
            1347.062,9.7935247024; 1347.565,9.7235568368; 1348.064,9.7482513776;
            1348.564,9.7852931888; 1349.061,9.7935247024; 1349.566,9.7770616752;
            1350.064,9.7647144048; 1350.566,9.760598648; 1351.064,9.7647144048;
            1351.563,9.7482513776; 1352.064,9.6906307824; 1352.564,9.698862296;
            1353.064,9.6659362416; 1353.565,9.6494732144; 1354.062,9.657704728;
            1354.564,9.6947465392; 1355.064,9.698862296; 1355.564,9.6700519984;
            1356.064,9.6947465392; 1356.564,9.698862296; 1357.064,9.6700519984;
            1357.564,9.7070938096; 1358.064,9.740019864; 1358.565,9.6865150256;
            1359.065,9.7359041072; 1359.565,9.7564828912; 1360.065,9.7523671344;
            1360.565,9.7235568368; 1361.064,9.7770616752; 1361.564,9.7482513776;
            1362.063,9.71944108; 1362.564,9.678283512; 1363.065,9.698862296;
            1363.561,9.7029780528; 1364.064,9.6947465392; 1364.563,9.6947465392;
            1365.063,9.7276725936; 1365.564,9.6947465392; 1366.065,9.6947465392;
            1366.564,9.71944108; 1367.064,9.7482513776; 1367.563,9.6865150256;
            1368.065,9.7276725936; 1368.562,9.6494732144; 1369.065,9.6453574576;
            1369.565,9.678283512; 1370.064,9.6823992688; 1370.564,9.7112095664;
            1371.064,9.7317883504; 1371.564,9.698862296; 1372.063,9.6947465392;
            1372.563,9.7029780528; 1373.064,9.7317883504; 1373.564,9.7564828912;
            1374.064,9.740019864; 1374.564,9.7852931888; 1375.065,9.7317883504;
            1375.564,9.7523671344; 1376.063,9.6906307824; 1376.565,9.5712738352;
            1377.064,8.9292157744; 1377.564,7.9661286832; 1378.064,7.0606621872;
            1378.564,6.3280574768; 1379.064,5.6366103344; 1379.564,5.109793464;
            1380.065,4.677639; 1380.565,4.2166742384; 1381.064,3.9738445872;
            1381.564,3.6322367728; 1382.065,3.4141016624; 1382.561,3.2453556336;
            1383.064,3.072493848; 1383.563,2.9654841712; 1384.063,2.804969656;
            1384.565,2.7103072496; 1385.065,2.6732654384; 1385.564,2.5662557616;
            1386.064,2.5004036528; 1386.565,2.4921721392; 1387.064,2.4098570032;
            1387.564,2.331657624; 1388.064,2.2822685424; 1388.564,2.2328794608;
            1389.063,2.249342488; 1389.564,2.1999534064; 1390.066,2.1546800816;
            1390.564,2.1793746224; 1391.065,2.146448568; 1391.564,2.1711431088;
            1392.064,2.146448568; 1392.563,2.1587958384; 1393.063,2.2040691632;
            1393.564,2.1999534064; 1394.064,2.2205321904; 1394.565,2.228763704;
            1395.063,2.2452267312; 1395.564,2.2987315696; 1396.065,2.2987315696;
            1396.565,2.269921272; 1397.063,2.3193103536; 1397.563,2.352236408;
            1398.063,2.4016254896; 1398.564,2.4468988144; 1399.063,2.4180885168;
            1399.567,2.4839406256; 1400.063,2.496287896; 1400.563,2.5250981936;
            1401.064,2.6032975728; 1401.564,2.5744872752; 1402.064,2.6485708976;
            1402.564,2.6321078704; 1403.064,2.6732654384; 1403.565,2.7391175472;
            1404.063,2.7391175472; 1404.565,2.7761593584; 1405.065,2.7679278448;
            1405.563,2.8132011696; 1406.064,2.8378957104; 1406.565,2.8914005488;
            1407.065,2.9037478192; 1407.564,2.8996320624; 1408.064,2.9613684144;
            1408.564,2.9449053872; 1409.064,2.969599928; 1409.561,2.9778314416;
            1410.064,3.0066417392; 1410.563,3.0395677936; 1411.065,3.0560308208;
            1411.564,3.0642623344; 1412.066,3.1589247408; 1412.561,3.1877350384;
            1413.064,3.2124295792; 1413.565,3.2823974448; 1414.062,3.3276707696;
            1414.564,3.319439256; 1415.064,3.3482495536; 1415.563,3.3852913648;
            1416.063,3.422333176; 1416.564,3.3976386352; 1417.063,3.4346804464;
            1417.563,3.4470277168; 1418.063,3.484069528; 1418.563,3.5293428528;
            1419.063,3.5416901232; 1419.564,3.5746161776; 1420.065,3.5211113392;
            1420.563,3.5293428528; 1421.065,3.5293428528; 1421.563,3.566384664;
            1422.064,3.607542232; 1422.564,3.6486998; 1423.065,3.710436152;
            1423.561,3.6322367728; 1424.065,3.6939731248; 1424.565,3.6816258544;
            1425.061,3.6939731248; 1425.565,3.6980888816; 1426.064,3.6857416112;
            1426.563,3.6733943408; 1427.064,3.6610470704; 1427.563,3.6528155568;
            1428.062,3.689857368; 1428.565,3.6445840432; 1429.063,3.6775100976;
            1429.561,3.6157737456; 1430.062,3.6528155568; 1430.565,3.6610470704;
            1431.062,3.6610470704; 1431.561,3.6157737456; 1432.063,3.6116579888;
            1432.564,3.6486998; 1433.064,3.6528155568; 1433.562,3.6857416112;
            1434.062,3.7392464496; 1434.56,3.6198895024; 1435.063,3.6240052592;
            1435.564,3.586963448; 1436.064,3.54580588; 1436.562,3.5087640688;
            1437.064,3.5211113392; 1437.564,3.5169955824; 1438.064,3.4511434736;
            1438.563,3.4346804464; 1439.063,3.4099859056; 1439.565,3.4470277168;
            1440.065,3.4511434736; 1440.564,3.3523653104; 1441.064,3.3112077424;
            1441.564,3.298860472; 1442.065,3.278281688; 1442.563,3.3359022832;
            1443.064,3.2618186608; 1443.565,3.2494713904; 1444.064,3.23712412;
            1444.564,3.2947447152; 1445.065,3.34001804; 1445.565,3.2947447152;
            1446.062,3.2453556336; 1446.563,3.2823974448; 1447.065,3.2330083632;
            1447.564,3.1301144432; 1448.065,3.1795035248; 1448.564,3.0560308208;
            1449.064,3.093072632; 1449.564,3.0148732528; 1450.063,3.0683780912;
            1450.561,3.0189890096; 1451.064,2.9654841712; 1451.565,2.9819471984;
            1452.064,2.8996320624; 1452.564,2.866706008; 1453.065,2.887284792;
            1453.563,2.8749375216; 1454.065,2.887284792; 1454.566,2.8378957104;
            1455.065,2.8708217648; 1455.562,2.8296641968; 1456.064,2.8708217648;
            1456.563,2.8132011696; 1457.064,2.8008538992; 1457.564,2.8132011696;
            1458.064,2.8090854128; 1458.564,2.804969656; 1459.064,2.7473490608;
            1459.564,2.8008538992; 1460.064,2.7679278448; 1460.562,2.7473490608;
            1461.065,2.7391175472; 1461.565,2.702075736; 1462.064,2.6979599792;
            1462.563,2.7103072496; 1463.062,2.6897284656; 1463.565,2.6897284656;
            1464.063,2.6938442224; 1464.564,2.7350017904; 1465.066,2.7473490608;
            1465.563,2.7144230064; 1466.064,2.72265452; 1466.563,2.7267702768;
            1467.063,2.743233304; 1467.564,2.6773811952; 1468.062,2.7514648176;
            1468.564,2.702075736; 1469.065,2.7308860336; 1469.561,2.6732654384;
            1470.063,2.6938442224; 1470.565,2.6568024112; 1471.065,2.6897284656;
            1471.564,2.6897284656; 1472.063,2.6526866544; 1472.565,2.6568024112;
            1473.061,2.6362236272; 1473.564,2.6074133296; 1474.062,2.6568024112;
            1474.564,2.6362236272; 1475.064,2.5868345456; 1475.564,2.660918168;
            1476.064,2.5950660592; 1476.565,2.6197606; 1477.063,2.640339384;
            1477.565,2.6197606; 1478.065,2.6074133296; 1478.565,2.537445464;
            1479.062,2.5333297072; 1479.56,2.5127509232; 1480.062,2.5456769776;
            1480.564,2.6197606; 1481.064,2.5127509232; 1481.563,2.5539084912;
            1482.065,2.5621400048; 1482.564,2.5497927344; 1483.064,2.6485708976;
            1483.563,2.5621400048; 1484.062,2.5127509232; 1484.566,2.5621400048;
            1485.064,2.51686668; 1485.565,2.4633618416; 1486.063,2.5333297072;
            1486.563,2.4674775984; 1487.062,2.5250981936; 1487.565,2.5662557616;
            1488.065,2.5456769776; 1488.564,2.578603032; 1489.064,2.5415612208;
            1489.564,2.5333297072; 1490.062,2.558024248; 1490.566,2.5456769776;
            1491.064,2.5415612208; 1491.56,2.5744872752; 1492.064,2.5909503024;
            1492.562,2.558024248; 1493.066,2.6074133296; 1493.566,2.5868345456;
            1494.063,2.6115290864; 1494.564,2.5621400048; 1495.063,2.6732654384;
            1495.565,2.6444551408; 1496.062,2.6485708976; 1496.565,2.6032975728;
            1497.062,2.6856127088; 1497.564,2.660918168; 1498.064,2.6526866544;
            1498.563,2.6691496816; 1499.061,2.6979599792; 1499.564,2.7144230064;
            1500.063,2.6732654384; 1500.565,2.7555805744; 1501.064,2.6938442224;
            1501.563,2.763812088; 1502.063,2.7761593584; 1502.561,2.804969656;
            1503.064,2.7967381424; 1503.565,2.7514648176; 1504.062,2.7885066288;
            1504.563,2.8296641968; 1505.064,2.784390872; 1505.564,2.846127224;
            1506.064,2.8090854128; 1506.564,2.8955163056; 1507.064,2.8378957104;
            1507.564,2.8543587376; 1508.064,2.8296641968; 1508.564,2.866706008;
            1509.061,2.8914005488; 1509.564,2.8790532784; 1510.063,2.887284792;
            1510.564,2.8914005488; 1511.065,2.8996320624; 1511.562,2.8708217648;
            1512.065,2.8955163056; 1512.563,2.907863576; 1513.063,2.8955163056;
            1513.563,2.9243266032; 1514.061,2.9325581168; 1514.564,2.8790532784;
            1515.064,2.9160950896; 1515.564,2.9407896304; 1516.065,3.0189890096;
            1516.564,3.03133628; 1517.065,2.990178712; 1517.566,2.907863576;
            1518.065,2.9654841712; 1518.564,2.9942944688; 1519.062,2.9778314416;
            1519.563,3.0272205232; 1520.063,2.9942944688; 1520.565,3.0395677936;
            1521.066,3.0066417392; 1521.564,3.0189890096; 1522.065,3.0642623344;
            1522.563,3.0189890096; 1523.062,3.0477993072; 1523.563,3.0477993072;
            1524.062,3.0436835504; 1524.563,3.0683780912; 1525.064,3.0848411184;
            1525.565,3.0889568752; 1526.065,3.0848411184; 1526.563,3.0766096048;
            1527.063,3.072493848; 1527.563,3.0848411184; 1528.062,3.0889568752;
            1528.562,3.051915064; 1529.06,3.1054199024; 1529.565,3.0807253616;
            1530.064,3.1218829296; 1530.564,3.1054199024; 1531.064,3.0477993072;
            1531.564,3.1424617136; 1532.064,3.1054199024; 1532.562,3.1630404976;
            1533.063,3.1054199024; 1533.565,3.1095356592; 1534.061,3.0642623344;
            1534.563,3.1218829296; 1535.064,3.0642623344; 1535.565,3.113651416;
            1536.064,3.0642623344; 1536.564,3.093072632; 1537.062,3.0766096048;
            1537.564,3.0601465776; 1538.063,3.0848411184; 1538.565,3.0971883888;
            1539.061,3.0642623344; 1539.566,3.0889568752; 1540.063,3.0148732528;
            1540.566,3.0683780912; 1541.062,3.0231047664; 1541.563,3.0560308208;
            1542.063,3.0766096048; 1542.563,3.0889568752; 1543.063,3.0642623344;
            1543.565,3.051915064; 1544.062,3.0601465776; 1544.563,3.0231047664;
            1545.062,3.0395677936; 1545.563,3.0395677936; 1546.064,3.0148732528;
            1546.564,3.0066417392; 1547.063,3.0272205232; 1547.561,3.0395677936;
            1548.061,3.0231047664; 1548.562,2.9984102256; 1549.062,3.03133628;
            1549.563,3.0025259824; 1550.062,2.9778314416; 1550.564,3.010757496;
            1551.064,2.9449053872; 1551.563,2.9737156848; 1552.063,2.9860629552;
            1552.565,2.9942944688; 1553.062,2.9243266032; 1553.56,2.9572526576;
            1554.062,2.9202108464; 1554.562,2.9202108464; 1555.062,2.8914005488;
            1555.565,2.9119793328; 1556.062,2.9160950896; 1556.561,2.8955163056;
            1557.062,2.907863576; 1557.565,2.8790532784; 1558.063,2.907863576;
            1558.563,2.8708217648; 1559.061,2.92844236; 1559.563,2.8790532784;
            1560.064,2.8955163056; 1560.564,2.8749375216; 1561.062,2.9449053872;
            1561.564,2.9202108464; 1562.064,2.9654841712; 1562.562,2.9366738736;
            1563.065,2.9407896304; 1563.562,2.907863576; 1564.064,2.949021144;
            1564.564,2.9037478192; 1565.065,2.9325581168; 1565.563,2.92844236;
            1566.062,2.949021144; 1566.564,2.92844236; 1567.062,2.92844236;
            1567.564,2.9243266032; 1568.063,2.8955163056; 1568.561,2.9531369008;
            1569.065,2.907863576; 1569.563,2.949021144; 1570.064,2.8955163056;
            1570.563,2.907863576; 1571.063,2.907863576; 1571.563,2.92844236;
            1572.061,2.9243266032; 1572.564,2.9243266032; 1573.065,2.9160950896;
            1573.564,2.969599928; 1574.062,2.9119793328; 1574.563,2.9449053872;
            1575.061,2.9119793328; 1575.561,2.907863576; 1576.062,2.92844236;
            1576.563,2.9202108464; 1577.064,2.9613684144; 1577.564,2.8996320624;
            1578.064,2.9778314416; 1578.564,2.92844236; 1579.062,3.010757496;
            1579.563,2.9613684144; 1580.064,2.9325581168; 1580.564,3.0148732528;
            1581.064,3.0231047664; 1581.564,3.0066417392; 1582.062,2.9407896304;
            1582.564,2.9654841712; 1583.063,2.9737156848; 1583.562,2.9325581168;
            1584.064,2.9737156848; 1584.564,2.990178712; 1585.065,3.0025259824;
            1585.563,2.9407896304; 1586.064,3.0642623344; 1586.564,3.0025259824;
            1587.065,2.9572526576; 1587.564,3.0395677936; 1588.063,2.9654841712;
            1588.564,2.9737156848; 1589.063,2.9243266032; 1589.564,2.9243266032;
            1590.063,2.92844236; 1590.565,2.8996320624; 1591.065,2.9243266032;
            1591.566,2.9037478192; 1592.065,2.9160950896; 1592.563,2.9366738736;
            1593.063,2.9407896304; 1593.565,2.9613684144; 1594.062,2.9407896304;
            1594.566,2.9737156848; 1595.063,2.9572526576; 1595.563,3.0066417392;
            1596.065,2.9613684144; 1596.563,3.0025259824; 1597.061,2.9572526576;
            1597.565,2.990178712; 1598.064,3.0231047664; 1598.566,2.9819471984;
            1599.061,2.9531369008; 1599.564,2.9819471984; 1600.064,2.9984102256;
            1600.564,3.03133628; 1601.065,2.9654841712; 1601.564,2.990178712;
            1602.065,2.9407896304; 1602.564,2.9654841712; 1603.063,2.9407896304;
            1603.564,2.9037478192; 1604.062,2.9531369008; 1604.564,2.9449053872;
            1605.065,2.9243266032; 1605.564,2.8955163056; 1606.066,2.9160950896;
            1606.566,2.8749375216; 1607.064,2.990178712; 1607.565,2.9860629552;
            1608.065,2.9613684144; 1608.562,2.969599928; 1609.065,2.9572526576;
            1609.563,2.949021144; 1610.063,2.9984102256; 1610.564,3.0025259824;
            1611.065,2.9737156848; 1611.565,2.9942944688; 1612.063,3.0354520368;
            1612.565,2.9819471984; 1613.061,3.0560308208; 1613.565,2.969599928;
            1614.064,3.0066417392; 1614.564,2.9572526576; 1615.064,2.9531369008;
            1615.564,3.0066417392; 1616.063,2.9654841712; 1616.563,2.9778314416;
            1617.061,3.0148732528; 1617.563,2.990178712; 1618.063,3.0148732528;
            1618.562,2.9984102256; 1619.063,2.990178712; 1619.565,2.9984102256;
            1620.065,2.990178712; 1620.565,2.9737156848; 1621.061,2.9942944688;
            1621.562,3.051915064; 1622.065,3.0189890096; 1622.563,3.0601465776;
            1623.062,3.0848411184; 1623.564,3.051915064; 1624.064,3.0971883888;
            1624.561,3.0272205232; 1625.063,3.0601465776; 1625.564,3.0231047664;
            1626.065,3.0354520368; 1626.564,3.051915064; 1627.062,3.0436835504;
            1627.564,3.051915064; 1628.062,3.051915064; 1628.565,3.0971883888;
            1629.064,3.1259986864; 1629.565,3.1177671728; 1630.063,3.0971883888;
            1630.565,3.0807253616; 1631.061,3.0848411184; 1631.566,3.1095356592;
            1632.065,3.1013041456; 1632.564,3.1054199024; 1633.064,3.1095356592;
            1633.564,3.113651416; 1634.064,3.0354520368; 1634.563,3.051915064;
            1635.064,3.0436835504; 1635.565,3.0066417392; 1636.064,3.0436835504;
            1636.562,3.0272205232; 1637.065,2.9942944688; 1637.565,3.0148732528;
            1638.061,2.9531369008; 1638.565,2.9984102256; 1639.065,2.9778314416;
            1639.564,2.9202108464; 1640.066,2.9984102256; 1640.565,2.9407896304;
            1641.064,2.9654841712; 1641.565,2.9942944688; 1642.064,2.9778314416;
            1642.564,3.0272205232; 1643.062,2.990178712; 1643.567,2.9942944688;
            1644.064,2.9860629552; 1644.564,2.9778314416; 1645.065,2.9984102256;
            1645.564,3.0025259824; 1646.065,2.990178712; 1646.565,3.0148732528;
            1647.064,3.0231047664; 1647.563,3.0066417392; 1648.065,2.9613684144;
            1648.565,2.9613684144; 1649.064,2.9654841712; 1649.563,2.9984102256;
            1650.063,2.9572526576; 1650.565,3.0766096048; 1651.065,3.0231047664;
            1651.564,2.9860629552; 1652.066,2.9778314416; 1652.565,2.9860629552;
            1653.064,2.9778314416; 1653.565,2.9654841712; 1654.061,3.0436835504;
            1654.561,3.0560308208; 1655.062,3.0889568752; 1655.561,3.1054199024;
            1656.061,3.113651416; 1656.563,3.1095356592; 1657.062,3.1383459568;
            1657.564,3.1177671728; 1658.065,3.113651416; 1658.566,3.0848411184;
            1659.065,3.0971883888; 1659.562,3.0272205232; 1660.062,3.0560308208;
            1660.563,3.0395677936; 1661.061,3.010757496; 1661.564,3.0231047664;
            1662.064,3.0436835504; 1662.566,3.0477993072; 1663.063,3.072493848;
            1663.563,3.0848411184; 1664.064,3.0148732528; 1664.561,3.0477993072;
            1665.065,3.0148732528; 1665.564,3.010757496; 1666.064,3.0231047664;
            1666.563,2.9984102256; 1667.065,3.0272205232; 1667.565,3.0477993072;
            1668.065,3.0354520368; 1668.562,3.0477993072; 1669.062,3.010757496;
            1669.563,3.0683780912; 1670.066,3.03133628; 1670.564,2.9942944688;
            1671.063,3.1013041456; 1671.565,3.051915064; 1672.064,2.9984102256;
            1672.565,3.0477993072; 1673.063,3.072493848; 1673.561,3.0601465776;
            1674.063,3.1054199024; 1674.563,3.072493848; 1675.063,3.03133628;
            1675.564,3.0148732528; 1676.065,3.0025259824; 1676.565,3.03133628;
            1677.063,3.0436835504; 1677.563,3.0971883888; 1678.064,3.1013041456;
            1678.564,3.0889568752; 1679.066,3.0766096048; 1679.563,3.0683780912;
            1680.064,3.0436835504; 1680.56,3.1218829296; 1681.063,3.1013041456;
            1681.561,3.0436835504; 1682.062,3.0683780912; 1682.565,3.0971883888;
            1683.062,3.1177671728; 1683.564,3.093072632; 1684.065,3.1054199024;
            1684.564,3.0642623344; 1685.065,3.03133628; 1685.565,3.0148732528;
            1686.065,3.051915064; 1686.563,2.9942944688; 1687.065,3.0025259824;
            1687.564,2.9613684144; 1688.064,2.9613684144; 1688.564,2.969599928;
            1689.065,2.9366738736; 1689.565,2.9860629552; 1690.064,2.9160950896;
            1690.564,2.92844236; 1691.065,2.969599928; 1691.564,2.9572526576;
            1692.067,2.9366738736; 1692.565,2.9243266032; 1693.062,2.9737156848;
            1693.565,2.9860629552; 1694.06,2.9366738736; 1694.565,2.9572526576;
            1695.065,2.9119793328; 1695.562,2.9737156848; 1696.064,2.9613684144;
            1696.566,2.969599928; 1697.064,2.9778314416; 1697.564,2.9572526576;
            1698.063,2.9984102256; 1698.562,2.9737156848; 1699.064,3.010757496;
            1699.565,2.9572526576; 1700.066,3.0025259824; 1700.562,3.03133628;
            1701.063,2.9860629552; 1701.564,3.0231047664; 1702.064,2.9984102256;
            1702.561,3.03133628; 1703.066,3.0436835504; 1703.565,3.0395677936;
            1704.065,3.093072632; 1704.564,3.0601465776; 1705.063,3.1095356592;
            1705.564,3.0889568752; 1706.062,3.1301144432; 1706.563,3.1877350384;
            1707.063,3.2288926064; 1707.565,3.1465774704; 1708.065,3.1301144432;
            1708.565,3.1259986864; 1709.065,3.1589247408; 1709.563,3.1054199024;
            1710.061,3.0477993072; 1710.564,3.0848411184; 1711.064,3.1218829296;
            1711.563,3.1259986864; 1712.063,3.0601465776; 1712.564,3.0971883888;
            1713.063,3.093072632; 1713.564,3.0807253616; 1714.064,3.1177671728;
            1714.565,3.1095356592; 1715.064,3.0560308208; 1715.566,3.113651416;
            1716.066,3.0683780912; 1716.564,3.0272205232; 1717.061,3.0354520368;
            1717.565,3.0354520368; 1718.062,3.0560308208; 1718.563,3.0436835504;
            1719.064,3.051915064; 1719.562,3.0477993072; 1720.065,3.0766096048;
            1720.565,3.051915064; 1721.065,3.072493848; 1721.564,3.0889568752;
            1722.065,3.0642623344; 1722.564,3.113651416; 1723.065,3.0560308208;
            1723.565,3.0601465776; 1724.065,3.0683780912; 1724.561,3.051915064;
            1725.064,3.072493848; 1725.564,3.0807253616; 1726.065,3.0807253616;
            1726.565,3.0848411184; 1727.064,3.0395677936; 1727.563,3.072493848;
            1728.064,3.1013041456; 1728.563,3.0683780912; 1729.065,3.0601465776;
            1729.564,3.0889568752; 1730.064,3.113651416; 1730.564,3.0889568752;
            1731.064,3.0807253616; 1731.564,3.1013041456; 1732.066,3.0807253616;
            1732.563,3.1177671728; 1733.064,3.0683780912; 1733.564,3.0560308208;
            1734.062,3.0971883888; 1734.562,3.113651416; 1735.063,3.0889568752;
            1735.563,3.1013041456; 1736.063,3.0766096048; 1736.565,3.1177671728;
            1737.064,3.0889568752; 1737.563,3.0683780912; 1738.063,3.0807253616;
            1738.565,3.0601465776; 1739.064,3.0807253616; 1739.562,3.072493848;
            1740.065,3.0889568752; 1740.561,3.093072632; 1741.066,3.0189890096;
            1741.564,3.1054199024; 1742.064,3.1506932272; 1742.563,3.1589247408;
            1743.062,3.1259986864; 1743.564,3.0601465776; 1744.063,3.0560308208;
            1744.562,3.093072632; 1745.063,3.113651416; 1745.564,3.0560308208;
            1746.065,3.0560308208; 1746.561,3.0807253616; 1747.062,3.1342302;
            1747.563,3.0683780912; 1748.065,3.1095356592; 1748.564,3.0766096048;
            1749.063,3.0807253616; 1749.562,3.1177671728; 1750.064,3.113651416;
            1750.564,3.0231047664; 1751.065,3.0848411184; 1751.566,3.0477993072;
            1752.064,3.072493848; 1752.565,3.0642623344; 1753.064,3.0683780912;
            1753.565,3.0848411184; 1754.066,3.0477993072; 1754.562,3.0807253616;
            1755.064,3.0436835504; 1755.563,3.0436835504; 1756.063,3.0354520368;
            1756.565,3.1177671728; 1757.065,3.0436835504; 1757.565,3.0889568752;
            1758.064,3.010757496; 1758.564,3.0395677936; 1759.063,3.0354520368;
            1759.563,3.0066417392; 1760.066,3.0354520368; 1760.563,3.1177671728;
            1761.065,3.0272205232; 1761.566,3.0848411184; 1762.063,3.0395677936;
            1762.564,3.0766096048; 1763.064,3.0231047664; 1763.563,3.072493848;
            1764.065,3.0642623344; 1764.562,3.0436835504; 1765.063,3.03133628;
            1765.565,3.1301144432; 1766.064,3.0395677936; 1766.563,3.0560308208;
            1767.065,3.0354520368; 1767.564,3.0231047664; 1768.065,3.051915064;
            1768.564,3.0436835504; 1769.064,3.072493848; 1769.562,3.1054199024;
            1770.065,3.093072632; 1770.562,3.0807253616; 1771.065,3.1013041456;
            1771.563,3.1177671728; 1772.064,3.1671562544; 1772.563,3.1301144432;
            1773.063,3.2124295792; 1773.564,3.1836192816; 1774.064,3.1712720112;
            1774.561,3.2083138224; 1775.064,3.1630404976; 1775.56,3.1795035248;
            1776.065,3.1301144432; 1776.564,3.1506932272; 1777.065,3.1095356592;
            1777.564,3.1177671728; 1778.066,3.1177671728; 1778.564,3.0766096048;
            1779.064,3.072493848; 1779.563,3.051915064; 1780.063,3.0766096048;
            1780.563,3.0848411184; 1781.064,3.0889568752; 1781.564,3.0642623344;
            1782.065,3.072493848; 1782.563,3.0807253616; 1783.063,3.0560308208;
            1783.563,3.072493848; 1784.066,3.093072632; 1784.562,3.0189890096;
            1785.066,3.051915064; 1785.564,3.0066417392; 1786.064,3.0066417392;
            1786.563,2.9778314416; 1787.063,3.0148732528; 1787.564,3.0436835504;
            1788.065,3.0272205232; 1788.564,3.072493848; 1789.064,3.051915064;
            1789.564,3.051915064; 1790.065,3.1054199024; 1790.564,3.051915064;
            1791.064,3.0642623344; 1791.564,3.0683780912; 1792.062,3.0066417392;
            1792.564,3.1506932272; 1793.063,3.0601465776; 1793.564,3.0683780912;
            1794.063,3.0560308208; 1794.562,3.0025259824; 1795.064,2.9984102256;
            1795.563,3.0848411184; 1796.064,3.03133628; 1796.565,3.0477993072;
            1797.064,3.0189890096; 1797.564,3.03133628; 1798.064,3.0848411184;
            1798.564,3.03133628; 1799.065,3.03133628; 1799.566,3.010757496;
            1800.062,2.9778314416; 1800.564,3.0601465776; 1801.063,3.0354520368;
            1801.566,3.0477993072; 1802.065,3.0189890096; 1802.565,3.0354520368;
            1803.065,2.9942944688; 1803.566,3.0272205232; 1804.063,3.072493848;
            1804.564,3.0477993072; 1805.065,3.0436835504; 1805.566,3.051915064;
            1806.065,3.0642623344; 1806.564,3.0395677936; 1807.064,3.051915064;
            1807.562,3.0272205232; 1808.063,3.010757496; 1808.563,3.0477993072;
            1809.065,3.0148732528; 1809.566,3.0848411184; 1810.065,3.0889568752;
            1810.564,3.0560308208; 1811.063,3.0766096048; 1811.565,3.0601465776;
            1812.066,3.093072632; 1812.565,3.1054199024; 1813.065,3.1013041456;
            1813.565,3.1013041456; 1814.063,3.1177671728; 1814.566,3.1013041456;
            1815.065,3.051915064; 1815.564,3.0601465776; 1816.066,3.0848411184;
            1816.565,3.093072632; 1817.065,3.1259986864; 1817.565,3.154808984;
            1818.065,3.1054199024; 1818.564,3.051915064; 1819.064,3.0848411184;
            1819.564,3.1095356592; 1820.066,3.1465774704; 1820.563,3.1259986864;
            1821.065,3.1218829296; 1821.565,3.1301144432; 1822.064,3.113651416;
            1822.565,3.1836192816; 1823.064,3.1671562544; 1823.564,3.1342302;
            1824.064,3.0971883888; 1824.565,3.093072632; 1825.064,3.0807253616;
            1825.565,3.1054199024; 1826.065,3.1259986864; 1826.565,3.1177671728;
            1827.065,3.0683780912; 1827.566,3.093072632; 1828.065,3.0766096048;
            1828.566,2.990178712; 1829.064,3.0148732528; 1829.565,3.0766096048;
            1830.065,3.0683780912; 1830.564,3.1301144432; 1831.065,3.1301144432;
            1831.565,3.093072632; 1832.064,3.1836192816; 1832.563,3.1177671728;
            1833.064,3.1342302; 1833.564,3.1177671728; 1834.062,3.1177671728;
            1834.562,3.1342302; 1835.065,3.0971883888; 1835.563,3.113651416;
            1836.065,3.1054199024; 1836.565,3.0971883888; 1837.064,3.0807253616;
            1837.564,3.0848411184; 1838.064,3.0683780912; 1838.564,3.0889568752;
            1839.064,3.113651416; 1839.565,3.0848411184; 1840.067,3.113651416;
            1840.565,3.1259986864; 1841.066,3.1506932272; 1841.564,3.1218829296;
            1842.065,3.1383459568; 1842.566,3.1465774704; 1843.064,3.1424617136;
            1843.563,3.1630404976; 1844.066,3.0848411184; 1844.566,3.1424617136;
            1845.065,3.1671562544; 1845.563,3.175387768; 1846.065,3.216545336;
            1846.565,3.2494713904; 1847.064,3.2288926064; 1847.566,3.2083138224;
            1848.066,3.216545336; 1848.566,3.2041980656; 1849.066,3.1877350384;
            1849.566,3.1836192816; 1850.066,3.1877350384; 1850.565,3.154808984;
            1851.065,3.1218829296; 1851.565,3.0971883888; 1852.064,3.1342302;
            1852.564,3.0807253616; 1853.065,3.0766096048; 1853.565,3.093072632;
            1854.065,3.0848411184; 1854.565,3.093072632; 1855.065,3.0848411184;
            1855.565,3.1177671728; 1856.061,3.1013041456; 1856.563,3.1342302;
            1857.064,3.1013041456; 1857.565,3.1054199024; 1858.065,3.1342302;
            1858.565,3.093072632; 1859.066,3.1259986864; 1859.564,3.0807253616;
            1860.064,3.0971883888; 1860.565,3.0642623344; 1861.064,3.0683780912;
            1861.565,3.1054199024; 1862.064,3.072493848; 1862.565,3.0642623344;
            1863.062,3.1218829296; 1863.565,3.113651416; 1864.061,3.0601465776;
            1864.563,3.113651416; 1865.063,3.0971883888; 1865.563,3.0683780912;
            1866.062,3.0807253616; 1866.566,3.1342302; 1867.065,3.0189890096;
            1867.565,3.0066417392; 1868.065,3.0395677936; 1868.564,3.1013041456;
            1869.064,3.0807253616; 1869.564,3.1013041456; 1870.066,3.0560308208;
            1870.566,2.9942944688; 1871.066,3.1013041456; 1871.563,3.1054199024;
            1872.063,3.0231047664; 1872.566,3.0807253616; 1873.065,3.113651416;
            1873.565,3.0889568752; 1874.062,3.0477993072; 1874.564,3.0272205232;
            1875.065,3.051915064; 1875.565,3.0642623344; 1876.066,3.072493848;
            1876.566,3.093072632; 1877.063,3.0395677936; 1877.563,3.0889568752;
            1878.064,3.0642623344; 1878.564,3.0395677936; 1879.063,3.0642623344;
            1879.562,3.0354520368; 1880.065,3.0766096048; 1880.563,3.0189890096;
            1881.062,3.0848411184; 1881.564,3.0971883888; 1882.064,3.0642623344;
            1882.565,3.0354520368; 1883.064,3.0848411184; 1883.565,3.0601465776;
            1884.065,3.0642623344; 1884.565,3.0807253616; 1885.064,3.0889568752;
            1885.562,3.1095356592; 1886.063,3.0683780912; 1886.565,3.0889568752;
            1887.066,3.0971883888; 1887.564,3.0642623344; 1888.064,3.0766096048;
            1888.565,3.0231047664; 1889.065,3.0601465776; 1889.564,3.1054199024;
            1890.063,3.051915064; 1890.564,3.0642623344; 1891.064,3.0642623344;
            1891.565,3.0477993072; 1892.064,3.0683780912; 1892.564,3.051915064;
            1893.065,3.1054199024; 1893.563,3.0066417392; 1894.063,3.0683780912;
            1894.562,3.0560308208; 1895.064,3.0560308208; 1895.565,3.03133628;
            1896.065,3.0971883888; 1896.565,3.0436835504; 1897.066,3.0601465776;
            1897.566,3.0395677936; 1898.063,3.051915064; 1898.563,3.0807253616;
            1899.064,3.0642623344; 1899.564,3.0889568752; 1900.065,3.072493848;
            1900.564,3.093072632; 1901.065,3.0807253616; 1901.565,3.093072632;
            1902.065,3.093072632; 1902.563,3.0971883888; 1903.063,3.0971883888;
            1903.565,3.1342302; 1904.061,3.0683780912; 1904.564,3.0354520368;
            1905.065,3.1013041456; 1905.565,3.1259986864; 1906.063,3.072493848;
            1906.565,3.072493848; 1907.066,3.093072632; 1907.564,3.0848411184;
            1908.066,3.1177671728; 1908.565,3.0807253616; 1909.065,3.0971883888;
            1909.565,3.1259986864; 1910.065,3.1259986864; 1910.566,3.1054199024;
            1911.065,3.1630404976; 1911.565,3.113651416; 1912.065,3.1506932272;
            1912.565,3.1177671728; 1913.064,3.1630404976; 1913.564,3.154808984;
            1914.064,3.1506932272; 1914.564,3.1218829296; 1915.066,3.1589247408;
            1915.562,3.1836192816; 1916.063,3.1424617136; 1916.565,3.1630404976;
            1917.064,3.154808984; 1917.565,3.2083138224; 1918.065,3.1630404976;
            1918.564,3.1712720112; 1919.063,3.1877350384; 1919.564,3.1795035248;
            1920.064,3.1465774704; 1920.566,3.2124295792; 1921.064,3.2124295792;
            1921.565,3.216545336; 1922.063,3.1712720112; 1922.564,3.0889568752;
            1923.065,3.1301144432; 1923.565,3.1177671728; 1924.062,3.1054199024;
            1924.564,3.175387768; 1925.06,3.1424617136; 1925.565,3.1013041456;
            1926.064,3.1630404976; 1926.564,3.113651416; 1927.065,3.1506932272;
            1927.565,3.1177671728; 1928.062,3.1589247408; 1928.564,3.1342302;
            1929.063,3.1177671728; 1929.565,3.1383459568; 1930.064,3.1465774704;
            1930.565,3.1506932272; 1931.064,3.113651416; 1931.563,3.0889568752;
            1932.063,3.1465774704; 1932.565,3.0848411184; 1933.065,3.1259986864;
            1933.562,3.0848411184; 1934.065,3.0560308208; 1934.563,3.072493848;
            1935.062,3.0766096048; 1935.565,3.0560308208; 1936.062,3.0148732528;
            1936.564,3.0066417392; 1937.065,3.0272205232; 1937.565,3.051915064;
            1938.065,3.0272205232; 1938.567,3.03133628; 1939.065,3.051915064;
            1939.563,3.0766096048; 1940.065,3.0807253616; 1940.566,3.0601465776;
            1941.063,3.1259986864; 1941.564,3.0683780912; 1942.066,3.1301144432;
            1942.565,3.1095356592; 1943.066,3.1013041456; 1943.565,3.072493848;
            1944.065,3.1095356592; 1944.562,3.0683780912; 1945.065,3.1095356592;
            1945.564,3.0889568752; 1946.062,3.1095356592; 1946.565,3.1630404976;
            1947.062,3.0971883888; 1947.563,3.1383459568; 1948.065,3.1424617136;
            1948.564,3.1589247408; 1949.061,3.1054199024; 1949.565,3.2041980656;
            1950.062,3.1836192816; 1950.563,3.278281688; 1951.065,3.2618186608;
            1951.565,3.216545336; 1952.066,3.23712412; 1952.563,3.1836192816;
            1953.065,3.1795035248; 1953.565,3.1918507952; 1954.065,3.1877350384;
            1954.564,3.154808984; 1955.065,3.1301144432; 1955.566,3.1506932272;
            1956.065,3.0766096048; 1956.565,3.1013041456; 1957.065,3.0971883888;
            1957.564,3.0971883888; 1958.064,3.1589247408; 1958.563,3.1259986864;
            1959.063,3.1095356592; 1959.565,3.1342302; 1960.065,3.1506932272;
            1960.564,3.1177671728; 1961.063,3.1671562544; 1961.565,3.1259986864;
            1962.063,3.1342302; 1962.562,3.1589247408; 1963.064,3.1465774704;
            1963.564,3.2000823088; 1964.065,3.1424617136; 1964.564,3.1383459568;
            1965.062,3.1301144432; 1965.562,3.1506932272; 1966.064,3.1465774704;
            1966.564,3.1013041456; 1967.065,3.0889568752; 1967.564,3.0971883888;
            1968.065,3.0848411184; 1968.566,3.0766096048; 1969.065,3.1506932272;
            1969.563,3.1712720112; 1970.064,3.2000823088; 1970.562,3.1177671728;
            1971.065,3.1465774704; 1971.564,3.1836192816; 1972.063,3.175387768;
            1972.565,3.1465774704; 1973.061,3.1877350384; 1973.564,3.2124295792;
            1974.065,3.2206610928; 1974.566,3.195966552; 1975.064,3.1589247408;
            1975.565,3.2330083632; 1976.064,3.2083138224; 1976.564,3.175387768;
            1977.065,3.1054199024; 1977.564,3.154808984; 1978.064,3.1177671728;
            1978.564,3.1465774704; 1979.066,3.0971883888; 1979.564,3.072493848;
            1980.066,3.093072632; 1980.565,3.1301144432; 1981.065,3.1013041456;
            1981.562,3.1218829296; 1982.065,3.0601465776; 1982.565,3.113651416;
            1983.065,3.1054199024; 1983.564,3.072493848; 1984.066,3.0848411184;
            1984.565,3.0560308208; 1985.065,3.1095356592; 1985.565,3.03133628;
            1986.065,3.1013041456; 1986.566,3.0807253616; 1987.066,3.1095356592;
            1987.565,3.1054199024; 1988.066,3.0889568752; 1988.565,3.0766096048;
            1989.065,3.0807253616; 1989.565,3.0889568752; 1990.065,3.072493848;
            1990.566,3.1177671728; 1991.065,3.154808984; 1991.565,3.2206610928;
            1992.063,3.2618186608; 1992.565,3.2618186608; 1993.066,3.2330083632;
            1993.567,3.2000823088; 1994.064,3.1877350384; 1994.562,3.1918507952;
            1995.065,3.1218829296; 1995.566,3.1383459568; 1996.064,3.093072632;
            1996.564,3.1383459568; 1997.065,3.0560308208; 1997.566,3.1465774704;
            1998.064,3.175387768; 1998.562,3.1795035248; 1999.064,3.2288926064;
            1999.565,3.1918507952; 2000.063,3.1259986864; 2000.566,3.1383459568;
            2001.064,3.1177671728; 2001.563,3.1218829296; 2002.065,3.1301144432;
            2002.565,3.1383459568; 2003.065,3.0971883888; 2003.564,3.1177671728;
            2004.066,3.113651416; 2004.562,3.1671562544; 2005.063,3.1342302;
            2005.564,3.1671562544; 2006.066,3.1589247408; 2006.566,3.175387768;
            2007.064,3.1712720112; 2007.566,3.2206610928; 2008.065,3.2247768496;
            2008.563,3.1877350384; 2009.066,3.1259986864; 2009.565,3.1795035248;
            2010.062,3.2288926064; 2010.563,3.2206610928; 2011.063,3.2041980656;
            2011.564,3.1095356592; 2012.067,3.1095356592; 2012.565,3.1095356592;
            2013.062,3.1383459568; 2013.567,3.1218829296; 2014.065,3.0971883888;
            2014.566,3.0807253616; 2015.063,3.0642623344; 2015.566,3.0395677936;
            2016.064,3.0848411184; 2016.564,3.113651416; 2017.067,3.0560308208;
            2017.565,3.1218829296; 2018.065,3.1095356592; 2018.565,3.072493848;
            2019.066,3.1342302; 2019.566,3.1218829296; 2020.061,3.1383459568;
            2020.565,3.1795035248; 2021.064,3.175387768; 2021.566,3.1301144432;
            2022.065,3.0807253616; 2022.566,3.1177671728; 2023.065,3.093072632;
            2023.562,3.2041980656; 2024.065,3.1218829296; 2024.563,3.1424617136;
            2025.062,3.1589247408; 2025.563,3.1671562544; 2026.064,3.1712720112;
            2026.565,3.2453556336; 2027.066,3.2700501744; 2027.565,3.3112077424;
            2028.066,3.2865132016; 2028.564,3.2659344176; 2029.066,3.1424617136;
            2029.564,3.154808984; 2030.061,3.2041980656; 2030.566,3.175387768;
            2031.065,3.1383459568; 2031.566,3.1218829296; 2032.063,3.1712720112;
            2032.565,3.0601465776; 2033.066,3.1465774704; 2033.565,3.1177671728;
            2034.067,3.113651416; 2034.567,3.1095356592; 2035.062,3.1383459568;
            2035.564,3.1630404976; 2036.065,3.1506932272; 2036.565,3.2083138224;
            2037.065,3.1671562544; 2037.566,3.1301144432; 2038.065,3.1095356592;
            2038.565,3.1712720112; 2039.064,3.0560308208; 2039.565,3.1218829296;
            2040.066,3.0971883888; 2040.565,3.1301144432; 2041.066,3.1671562544;
            2041.564,3.175387768; 2042.066,3.1383459568; 2042.565,3.1301144432;
            2043.065,3.113651416; 2043.565,3.1918507952; 2044.066,3.1877350384;
            2044.566,3.2124295792; 2045.065,3.1712720112; 2045.566,3.1671562544;
            2046.065,3.1918507952; 2046.561,3.1383459568; 2047.066,3.1630404976;
            2047.565,3.1424617136; 2048.065,3.1465774704; 2048.565,3.1218829296;
            2049.066,3.1259986864; 2049.566,3.1383459568; 2050.066,3.0766096048;
            2050.565,3.072493848; 2051.064,3.1054199024; 2051.562,3.1095356592;
            2052.062,3.0766096048; 2052.564,3.0642623344; 2053.066,3.0354520368;
            2053.566,3.0889568752; 2054.066,3.093072632; 2054.566,3.0807253616;
            2055.065,3.0642623344; 2055.562,3.0889568752; 2056.065,3.0766096048;
            2056.566,3.113651416; 2057.065,3.0807253616; 2057.562,3.0848411184;
            2058.065,3.0971883888; 2058.565,3.1054199024; 2059.066,3.0889568752;
            2059.564,3.0889568752; 2060.063,3.0395677936; 2060.563,3.03133628;
            2061.065,3.051915064; 2061.566,3.0477993072; 2062.065,3.1013041456;
            2062.565,3.1218829296; 2063.066,3.0848411184; 2063.563,3.113651416;
            2064.067,3.1383459568; 2064.565,3.1013041456; 2065.066,3.1589247408;
            2065.565,3.1795035248; 2066.065,3.2041980656; 2066.565,3.2412398768;
            2067.066,3.2288926064; 2067.564,3.2412398768; 2068.063,3.216545336;
            2068.565,3.1877350384; 2069.065,3.2083138224; 2069.562,3.1836192816;
            2070.062,3.154808984; 2070.575,3.1671562544; 2071.07,3.1630404976;
            2071.565,3.1836192816; 2072.064,3.1054199024; 2072.565,3.195966552;
            2073.065,3.154808984; 2073.563,3.1671562544; 2074.066,3.1671562544;
            2074.566,3.1836192816; 2075.064,3.216545336; 2075.565,3.1918507952;
            2076.063,3.1836192816; 2076.564,3.154808984; 2077.065,3.175387768;
            2077.566,3.1712720112; 2078.066,3.1671562544; 2078.562,3.1795035248;
            2079.065,3.1918507952; 2079.563,3.175387768; 2080.064,3.1671562544;
            2080.566,3.1301144432; 2081.063,3.1013041456; 2081.563,3.1054199024;
            2082.065,3.0560308208; 2082.564,3.0807253616; 2083.065,3.0971883888;
            2083.564,3.1506932272; 2084.066,3.1877350384; 2084.564,3.154808984;
            2085.066,3.1918507952; 2085.564,3.2124295792; 2086.065,3.175387768;
            2086.562,3.216545336; 2087.062,3.154808984; 2087.564,3.1095356592;
            2088.065,3.175387768; 2088.565,3.1836192816; 2089.065,3.2124295792;
            2089.565,3.2206610928; 2090.065,3.1671562544; 2090.564,3.2000823088;
            2091.063,3.175387768; 2091.565,3.2124295792; 2092.065,3.2412398768;
            2092.566,3.1630404976; 2093.065,3.2083138224; 2093.566,3.1342302;
            2094.064,3.1630404976; 2094.565,3.1424617136; 2095.065,3.1424617136;
            2095.568,3.1259986864; 2096.065,3.1054199024; 2096.565,3.1465774704;
            2097.067,3.1383459568; 2097.565,3.093072632; 2098.065,3.072493848;
            2098.565,3.1465774704; 2099.066,3.0971883888; 2099.565,3.1095356592;
            2100.066,3.1095356592; 2100.566,3.1013041456; 2101.065,3.0642623344;
            2101.565,3.0971883888; 2102.064,3.051915064; 2102.565,3.0066417392;
            2103.065,3.0148732528; 2103.564,3.0395677936; 2104.065,3.03133628;
            2104.567,3.0642623344; 2105.064,3.1054199024; 2105.565,3.0889568752;
            2106.065,3.051915064; 2106.565,3.0477993072; 2107.065,3.1342302;
            2107.566,3.072493848; 2108.068,3.0231047664; 2108.562,3.03133628;
            2109.066,3.0683780912; 2109.564,3.1301144432; 2110.062,3.113651416;
            2110.562,3.0848411184; 2111.063,3.0848411184; 2111.562,3.0683780912;
            2112.062,3.051915064; 2112.566,3.0889568752; 2113.065,3.0477993072;
            2113.564,3.03133628; 2114.066,3.072493848; 2114.562,3.0601465776;
            2115.062,3.0766096048; 2115.565,3.1013041456; 2116.066,3.0766096048;
            2116.563,3.1506932272; 2117.065,3.0560308208; 2117.563,3.1630404976;
            2118.063,3.1259986864; 2118.562,3.0766096048; 2119.063,3.1342302;
            2119.562,3.093072632; 2120.062,3.0848411184; 2120.563,3.0807253616;
            2121.063,3.1342302; 2121.562,3.1013041456; 2122.063,3.1342302;
            2122.563,3.154808984; 2123.063,3.1424617136; 2123.565,3.1465774704;
            2124.064,3.1671562544; 2124.564,3.1589247408; 2125.064,3.1506932272;
            2125.565,3.1383459568; 2126.064,3.1630404976; 2126.564,3.1630404976;
            2127.064,3.216545336; 2127.564,3.2041980656; 2128.065,3.2412398768;
            2128.563,3.2247768496; 2129.064,3.2288926064; 2129.566,3.2247768496;
            2130.065,3.2494713904; 2130.564,3.2906289584; 2131.066,3.278281688;
            2131.565,3.2453556336; 2132.066,3.23712412; 2132.566,3.195966552;
            2133.065,3.2083138224; 2133.563,3.2206610928; 2134.063,3.2206610928;
            2134.565,3.216545336; 2135.065,3.2206610928; 2135.563,3.2535871472;
            2136.065,3.2618186608; 2136.564,3.2083138224; 2137.066,3.2288926064;
            2137.563,3.1671562544; 2138.066,3.1506932272; 2138.565,3.195966552;
            2139.064,3.257702904; 2139.563,3.1795035248; 2140.064,3.2453556336;
            2140.564,3.2535871472; 2141.064,3.2535871472; 2141.563,3.2494713904;
            2142.064,3.2741659312; 2142.562,3.3029762288; 2143.065,3.2906289584;
            2143.566,3.2823974448; 2144.062,3.2906289584; 2144.565,3.2618186608;
            2145.063,3.2741659312; 2145.563,3.2823974448; 2146.066,3.2659344176;
            2146.562,3.23712412; 2147.062,3.216545336; 2147.565,3.195966552;
            2148.065,3.2535871472; 2148.563,3.2288926064; 2149.066,3.1877350384;
            2149.565,3.2330083632; 2150.066,3.1712720112; 2150.565,3.1712720112;
            2151.066,3.1465774704; 2151.566,3.1342302; 2152.063,3.1712720112;
            2152.565,3.1424617136; 2153.066,3.1836192816; 2153.566,3.1259986864;
            2154.065,3.1877350384; 2154.562,3.1465774704; 2155.062,3.1836192816;
            2155.563,3.2000823088; 2156.064,3.1301144432; 2156.564,3.1877350384;
            2157.065,3.093072632; 2157.565,3.0807253616; 2158.065,3.0971883888;
            2158.564,3.1712720112; 2159.064,3.1712720112; 2159.565,3.175387768;
            2160.065,3.2000823088; 2160.563,3.1712720112; 2161.064,3.1712720112;
            2161.566,3.1465774704; 2162.064,3.1712720112; 2162.564,3.2041980656;
            2163.064,3.2041980656; 2163.566,3.2000823088; 2164.065,3.113651416;
            2164.563,3.1795035248; 2165.064,3.1918507952; 2165.565,3.1218829296;
            2166.065,3.2041980656; 2166.565,3.1836192816; 2167.064,3.1712720112;
            2167.565,3.1712720112; 2168.065,3.1506932272; 2168.564,3.1383459568;
            2169.066,3.0889568752; 2169.564,3.1054199024; 2170.066,3.1013041456;
            2170.565,3.1218829296; 2171.066,3.1013041456; 2171.564,3.1383459568;
            2172.066,3.1301144432; 2172.565,3.2000823088; 2173.065,3.1918507952;
            2173.565,3.216545336; 2174.066,3.216545336; 2174.564,3.1671562544;
            2175.064,3.1795035248; 2175.564,3.2000823088; 2176.065,3.1836192816;
            2176.565,3.175387768; 2177.065,3.1836192816; 2177.565,3.1671562544;
            2178.064,3.1671562544; 2178.566,3.1506932272; 2179.064,3.1795035248;
            2179.563,3.1259986864; 2180.066,3.175387768; 2180.563,3.1383459568;
            2181.065,3.1383459568; 2181.565,3.1506932272; 2182.065,3.1301144432;
            2182.563,3.0971883888; 2183.066,3.0560308208; 2183.564,3.051915064;
            2184.064,3.0477993072; 2184.562,3.0848411184; 2185.066,3.1465774704;
            2185.565,3.0807253616; 2186.065,3.1342302; 2186.566,3.1259986864;
            2187.065,3.1712720112; 2187.565,3.154808984; 2188.065,3.154808984;
            2188.565,3.1342302; 2189.064,3.1259986864; 2189.565,3.1424617136;
            2190.065,3.1259986864; 2190.564,3.1630404976; 2191.064,3.154808984;
            2191.564,3.154808984; 2192.065,3.175387768; 2192.564,3.1795035248;
            2193.066,3.1795035248; 2193.564,3.154808984; 2194.065,3.2247768496;
            2194.565,3.1671562544; 2195.065,3.1836192816; 2195.566,3.1712720112;
            2196.064,3.175387768; 2196.565,3.175387768; 2197.064,3.1465774704;
            2197.562,3.1424617136; 2198.064,3.2412398768; 2198.564,3.2124295792;
            2199.065,3.1301144432; 2199.563,3.1383459568; 2200.065,3.1671562544;
            2200.565,3.1465774704; 2201.064,3.1712720112; 2201.565,3.0889568752;
            2202.065,3.1630404976; 2202.563,3.1671562544; 2203.064,3.1383459568;
            2203.565,3.1795035248; 2204.067,3.1218829296; 2204.564,3.1589247408;
            2205.065,3.1465774704; 2205.562,3.1383459568; 2206.065,3.0889568752;
            2206.565,3.1301144432; 2207.066,3.093072632; 2207.565,3.0848411184;
            2208.065,3.1054199024; 2208.564,3.1054199024; 2209.065,3.1424617136;
            2209.566,3.1383459568; 2210.065,3.1259986864; 2210.561,3.1218829296;
            2211.065,3.1383459568; 2211.563,3.154808984; 2212.065,3.1383459568;
            2212.565,3.1836192816; 2213.066,3.2083138224; 2213.564,3.1918507952;
            2214.065,3.2041980656; 2214.565,3.1589247408; 2215.065,3.1877350384;
            2215.561,3.2124295792; 2216.064,3.1877350384; 2216.563,3.2330083632;
            2217.064,3.1671562544; 2217.563,3.1836192816; 2218.066,3.1671562544;
            2218.566,3.1877350384; 2219.066,3.154808984; 2219.565,3.1877350384;
            2220.064,3.1589247408; 2220.561,3.1506932272; 2221.066,3.1836192816;
            2221.565,3.175387768; 2222.066,3.2083138224; 2222.565,3.1589247408;
            2223.066,3.1712720112; 2223.566,3.2000823088; 2224.065,3.1836192816;
            2224.566,3.2330083632; 2225.065,3.195966552; 2225.562,3.175387768;
            2226.065,3.2206610928; 2226.565,3.216545336; 2227.067,3.2535871472;
            2227.564,3.2412398768; 2228.065,3.2659344176; 2228.565,3.2206610928;
            2229.067,3.2659344176; 2229.565,3.23712412; 2230.066,3.298860472;
            2230.562,3.3112077424; 2231.065,3.2947447152; 2231.565,3.2741659312;
            2232.065,3.1630404976; 2232.565,3.1630404976; 2233.065,3.1424617136;
            2233.567,3.1465774704; 2234.067,3.113651416; 2234.566,3.1506932272;
            2235.066,3.1054199024; 2235.562,3.0971883888; 2236.065,3.093072632;
            2236.562,3.1383459568; 2237.065,3.0971883888; 2237.563,3.1259986864;
            2238.066,3.0560308208; 2238.565,3.0766096048; 2239.066,3.1095356592;
            2239.566,3.0683780912; 2240.066,3.093072632; 2240.563,3.0560308208;
            2241.065,3.1054199024; 2241.566,3.072493848; 2242.065,3.072493848;
            2242.566,3.0766096048; 2243.066,3.0889568752; 2243.565,3.1259986864;
            2244.064,3.0848411184; 2244.566,3.1013041456; 2245.065,3.1506932272;
            2245.562,3.1795035248; 2246.065,3.1506932272; 2246.566,3.0601465776;
            2247.066,3.0231047664; 2247.564,3.051915064; 2248.066,3.0889568752;
            2248.565,3.0642623344; 2249.067,3.1383459568; 2249.565,3.051915064;
            2250.066,3.0642623344; 2250.564,3.0436835504; 2251.064,3.0354520368;
            2251.565,3.0477993072; 2252.065,3.1013041456; 2252.565,3.0807253616;
            2253.066,3.1054199024; 2253.566,3.1671562544; 2254.065,3.1383459568;
            2254.567,3.113651416; 2255.066,3.154808984; 2255.563,3.1177671728;
            2256.066,3.154808984; 2256.564,3.1630404976; 2257.065,3.1342302;
            2257.565,3.1712720112; 2258.065,3.1712720112; 2258.566,3.2412398768;
            2259.067,3.1589247408; 2259.565,3.1918507952; 2260.064,3.23712412;
            2260.561,3.216545336; 2261.065,3.1918507952; 2261.565,3.2247768496;
            2262.065,3.195966552; 2262.564,3.2000823088; 2263.065,3.216545336;
            2263.566,3.1671562544; 2264.065,3.1877350384; 2264.566,3.1918507952;
            2265.064,3.1712720112; 2265.561,3.1342302; 2266.065,3.1589247408;
            2266.567,3.1589247408; 2267.066,3.1465774704; 2267.567,3.1177671728;
            2268.064,3.175387768; 2268.566,3.1630404976; 2269.066,3.1342302;
            2269.565,3.0848411184; 2270.065,3.1177671728; 2270.562,3.0766096048;
            2271.067,3.093072632; 2271.566,3.1383459568; 2272.066,3.1795035248;
            2272.565,3.1506932272; 2273.066,3.1465774704; 2273.565,3.2041980656;
            2274.065,3.1795035248; 2274.564,3.1589247408; 2275.065,3.1465774704;
            2275.565,3.154808984; 2276.067,3.1506932272; 2276.565,3.1795035248;
            2277.066,3.1877350384; 2277.566,3.1795035248; 2278.067,3.2124295792;
            2278.565,3.175387768; 2279.064,3.1918507952; 2279.564,3.2124295792;
            2280.064,3.1342302; 2280.566,3.2000823088; 2281.065,3.1301144432;
            2281.565,3.1795035248; 2282.066,3.154808984; 2282.566,3.1342302;
            2283.067,3.1013041456; 2283.564,3.195966552; 2284.067,3.2124295792;
            2284.565,3.1671562544; 2285.064,3.1259986864; 2285.565,3.1259986864;
            2286.066,3.1712720112; 2286.567,3.1712720112; 2287.065,3.1712720112;
            2287.565,3.1465774704; 2288.067,3.2000823088; 2288.566,3.1259986864;
            2289.065,3.1342302; 2289.566,3.1054199024; 2290.067,3.175387768;
            2290.566,3.1918507952; 2291.067,3.1630404976; 2291.566,3.2083138224;
            2292.066,3.1671562544; 2292.565,3.23712412; 2293.066,3.2288926064;
            2293.565,3.2041980656; 2294.066,3.2906289584; 2294.566,3.2453556336;
            2295.066,3.2618186608; 2295.567,3.2618186608; 2296.066,3.2823974448;
            2296.565,3.3441337968; 2297.066,3.2535871472; 2297.566,3.2330083632;
            2298.065,3.2330083632; 2298.565,3.2124295792; 2299.065,3.257702904;
            2299.566,3.278281688; 2300.064,3.257702904; 2300.566,3.23712412;
            2301.065,3.2247768496; 2301.566,3.2330083632; 2302.065,3.2535871472;
            2302.565,3.2618186608; 2303.066,3.2206610928; 2303.566,3.2865132016;
            2304.066,3.3029762288; 2304.565,3.23712412; 2305.066,3.2659344176;
            2305.564,3.298860472; 2306.065,3.2247768496; 2306.565,3.3235550128;
            2307.065,3.2494713904; 2307.563,3.3029762288; 2308.064,3.2865132016;
            2308.565,3.2947447152; 2309.064,3.2865132016; 2309.565,3.3153234992;
            2310.064,3.298860472; 2310.566,3.319439256; 2311.066,3.3359022832;
            2311.564,3.3112077424; 2312.067,3.3112077424; 2312.566,3.2823974448;
            2313.066,3.3112077424; 2313.566,3.2041980656; 2314.066,3.2124295792;
            2314.566,3.1836192816; 2315.065,3.1589247408; 2315.567,3.1795035248;
            2316.066,3.2330083632; 2316.566,3.2453556336; 2317.067,3.2330083632;
            2317.567,3.1836192816; 2318.063,3.175387768; 2318.567,3.2000823088;
            2319.065,3.1424617136; 2319.567,3.1424617136; 2320.066,3.1301144432;
            2320.565,3.1630404976; 2321.067,3.113651416; 2321.566,3.1301144432;
            2322.064,3.0971883888; 2322.566,3.1712720112; 2323.066,3.0971883888;
            2323.565,3.195966552; 2324.066,3.093072632; 2324.566,3.0766096048;
            2325.065,3.0848411184; 2325.565,3.1218829296; 2326.066,3.1589247408;
            2326.565,3.1301144432; 2327.065,3.1177671728; 2327.565,3.1712720112;
            2328.062,3.195966552; 2328.564,3.1712720112; 2329.066,3.2000823088;
            2329.565,3.1383459568; 2330.066,3.1342302; 2330.567,3.1301144432;
            2331.065,3.1795035248; 2331.565,3.1671562544; 2332.065,3.1630404976;
            2332.565,3.1630404976; 2333.066,3.1177671728; 2333.567,3.1383459568;
            2334.067,3.1342302; 2334.567,3.0642623344; 2335.066,3.1506932272;
            2335.565,3.1671562544; 2336.066,3.1795035248; 2336.565,3.1795035248;
            2337.065,3.154808984; 2337.565,3.2000823088; 2338.066,3.1918507952;
            2338.565,3.195966552; 2339.066,3.2000823088; 2339.566,3.175387768;
            2340.066,3.1712720112; 2340.567,3.216545336; 2341.066,3.195966552;
            2341.567,3.1918507952; 2342.065,3.1630404976; 2342.566,3.1836192816;
            2343.066,3.216545336; 2343.565,3.1836192816; 2344.063,3.23712412;
            2344.567,3.1918507952; 2345.064,3.2041980656; 2345.564,3.1301144432;
            2346.065,3.1630404976; 2346.567,3.1218829296; 2347.063,3.1877350384;
            2347.564,3.1259986864; 2348.064,3.1383459568; 2348.565,3.1589247408;
            2349.067,3.1095356592; 2349.564,3.1054199024; 2350.065,3.0642623344;
            2350.565,3.1259986864; 2351.065,3.0971883888; 2351.566,3.1013041456;
            2352.066,3.0889568752; 2352.564,3.1259986864; 2353.065,3.1095356592;
            2353.564,3.0848411184; 2354.065,3.072493848; 2354.564,3.1424617136;
            2355.063,3.1424617136; 2355.563,3.1013041456; 2356.066,3.1218829296;
            2356.565,3.1301144432; 2357.063,3.1424617136; 2357.565,3.1259986864;
            2358.061,3.1301144432; 2358.566,3.1054199024; 2359.066,3.1095356592;
            2359.566,3.1218829296; 2360.064,3.1259986864; 2360.565,3.1465774704;
            2361.066,3.1342302; 2361.567,3.1424617136; 2362.065,3.1918507952;
            2362.565,3.2330083632; 2363.066,3.298860472; 2363.566,3.2947447152;
            2364.066,3.2823974448; 2364.567,3.2412398768; 2365.066,3.1918507952;
            2365.565,3.195966552; 2366.099,3.1424617136; 2366.567,3.1712720112;
            2367.065,3.1918507952; 2367.563,3.1013041456; 2368.066,3.1301144432;
            2368.565,3.1177671728; 2369.064,3.113651416; 2369.566,3.2247768496;
            2370.064,3.1836192816; 2370.566,3.195966552; 2371.067,3.2000823088;
            2371.565,3.1342302; 2372.066,3.154808984; 2372.566,3.1671562544;
            2373.066,3.2041980656; 2373.566,3.113651416; 2374.067,3.0889568752;
            2374.566,3.0766096048; 2375.065,3.0683780912; 2375.565,3.1054199024;
            2376.067,3.1630404976; 2376.565,3.216545336; 2377.066,3.1918507952;
            2377.566,3.1589247408; 2378.066,3.1918507952; 2378.565,3.216545336;
            2379.065,3.2124295792; 2379.566,3.2494713904; 2380.065,3.175387768;
            2380.566,3.2083138224; 2381.065,3.2494713904; 2381.566,3.2330083632;
            2382.066,3.154808984; 2382.565,3.175387768; 2383.065,3.2083138224;
            2383.563,3.175387768; 2384.063,3.1013041456; 2384.566,3.1218829296;
            2385.067,3.1301144432; 2385.566,3.0807253616; 2386.065,3.1506932272;
            2386.565,3.113651416; 2387.067,3.1013041456; 2387.566,3.0971883888;
            2388.065,3.113651416; 2388.565,3.113651416; 2389.066,3.1218829296;
            2389.566,3.113651416; 2390.067,3.113651416; 2390.565,3.1342302;
            2391.066,3.1301144432; 2391.564,3.1671562544; 2392.065,3.1259986864;
            2392.567,3.0889568752; 2393.065,3.0807253616; 2393.566,3.0889568752;
            2394.065,3.0354520368; 2394.565,3.113651416; 2395.066,3.093072632;
            2395.564,3.1095356592; 2396.064,3.1177671728; 2396.565,3.1095356592;
            2397.065,3.093072632; 2397.563,3.1671562544; 2398.066,3.2000823088;
            2398.566,3.1795035248; 2399.067,3.2453556336; 2399.566,3.2288926064;
            2400.066,3.2659344176; 2400.564,3.2247768496; 2401.066,3.2535871472;
            2401.567,3.1630404976; 2402.065,3.2494713904; 2402.567,3.1795035248;
            2403.064,3.2041980656; 2403.565,3.1918507952; 2404.064,3.195966552;
            2404.565,3.1836192816; 2405.065,3.2041980656; 2405.566,3.1506932272;
            2406.066,3.1589247408; 2406.566,3.1589247408; 2407.064,3.154808984;
            2407.566,3.1630404976; 2408.066,3.175387768; 2408.563,3.1671562544;
            2409.066,3.1671562544; 2409.566,3.1671562544; 2410.066,3.1054199024;
            2410.566,3.1877350384; 2411.065,3.1795035248; 2411.562,3.1465774704;
            2412.066,3.1671562544; 2412.565,3.1712720112; 2413.066,3.1383459568;
            2413.565,3.1630404976; 2414.065,3.175387768; 2414.567,3.1301144432;
            2415.065,3.1630404976; 2415.566,3.1589247408; 2416.067,3.1836192816;
            2416.567,3.1218829296; 2417.066,3.1589247408; 2417.565,3.0766096048;
            2418.065,3.0971883888; 2418.563,3.0766096048; 2419.066,3.1877350384;
            2419.563,3.1671562544; 2420.065,3.2041980656; 2420.564,3.2000823088;
            2421.066,3.195966552; 2421.567,3.1671562544; 2422.066,3.175387768;
            2422.567,3.2041980656; 2423.065,3.216545336; 2423.565,3.2247768496;
            2424.063,3.2041980656; 2424.565,3.2330083632; 2425.067,3.1918507952;
            2425.563,3.2453556336; 2426.064,3.2124295792; 2426.567,3.195966552;
            2427.066,3.1465774704; 2427.565,3.1836192816; 2428.066,3.1465774704;
            2428.566,3.1506932272; 2429.066,3.154808984; 2429.566,3.1589247408;
            2430.066,3.1506932272; 2430.565,3.1671562544; 2431.066,3.1383459568;
            2431.565,3.1424617136; 2432.066,3.1177671728; 2432.567,3.072493848;
            2433.066,3.1095356592; 2433.565,3.0807253616; 2434.067,3.113651416;
            2434.565,3.0807253616; 2435.065,3.072493848; 2435.562,3.0807253616;
            2436.067,3.0848411184; 2436.564,3.1013041456; 2437.066,3.072493848;
            2437.567,3.1259986864; 2438.066,3.1177671728; 2438.567,3.1465774704;
            2439.066,3.093072632; 2439.567,3.1259986864; 2440.066,3.1054199024;
            2440.567,3.1177671728; 2441.067,3.1177671728; 2441.563,3.1671562544;
            2442.062,3.1630404976; 2442.563,3.1630404976; 2443.067,3.1506932272;
            2443.565,3.1342302; 2444.066,3.1218829296; 2444.562,3.113651416;
            2445.065,3.1342302; 2445.567,3.1095356592; 2446.065,3.1671562544;
            2446.566,3.1095356592; 2447.066,3.1301144432; 2447.565,3.1342302;
            2448.066,3.154808984; 2448.565,3.1506932272; 2449.064,3.1177671728;
            2449.565,3.1589247408; 2450.066,3.1630404976; 2450.565,3.1465774704;
            2451.065,3.154808984; 2451.566,3.2000823088; 2452.067,3.1630404976;
            2452.564,3.175387768; 2453.066,3.2288926064; 2453.566,3.2741659312;
            2454.065,3.2741659312; 2454.565,3.2906289584; 2455.066,3.2618186608;
            2455.566,3.2535871472; 2456.064,3.1671562544; 2456.565,3.2000823088;
            2457.065,3.1712720112; 2457.565,3.1301144432; 2458.066,3.1836192816;
            2458.566,3.1218829296; 2459.067,3.1424617136; 2459.566,3.1054199024;
            2460.065,3.0971883888; 2460.565,3.175387768; 2461.066,3.1836192816;
            2461.566,3.1465774704; 2462.066,3.1671562544; 2462.565,3.175387768;
            2463.065,3.1712720112; 2463.567,3.1630404976; 2464.065,3.1630404976;
            2464.567,3.1918507952; 2465.065,3.1795035248; 2465.561,3.1177671728;
            2466.066,3.1795035248; 2466.564,3.1177671728; 2467.066,3.154808984;
            2467.566,3.1465774704; 2468.065,3.0889568752; 2468.566,3.1095356592;
            2469.065,3.1424617136; 2469.565,3.1671562544; 2470.066,3.1589247408;
            2470.565,3.1795035248; 2471.064,3.1836192816; 2471.566,3.2000823088;
            2472.062,3.1424617136; 2472.566,3.1259986864; 2473.066,3.175387768;
            2473.566,3.216545336; 2474.067,3.2247768496; 2474.566,3.2000823088;
            2475.065,3.175387768; 2475.565,3.2083138224; 2476.063,3.195966552;
            2476.566,3.2412398768; 2477.066,3.1795035248; 2477.565,3.1671562544;
            2478.067,3.1877350384; 2478.565,3.1795035248; 2479.067,3.1589247408;
            2479.566,3.0848411184; 2480.065,3.1259986864; 2480.566,3.1630404976;
            2481.066,3.1054199024; 2481.564,3.1054199024; 2482.065,3.1259986864;
            2482.567,3.1342302; 2483.066,3.1259986864; 2483.565,3.0971883888;
            2484.067,3.0807253616; 2484.564,3.1054199024; 2485.066,3.0601465776;
            2485.566,3.0683780912; 2486.066,3.0560308208; 2486.565,3.1095356592;
            2487.065,3.1054199024; 2487.564,3.0683780912; 2488.065,3.1095356592;
            2488.562,3.1013041456; 2489.065,3.113651416; 2489.565,3.1259986864;
            2490.066,3.1301144432; 2490.565,3.1342302; 2491.064,3.1589247408;
            2491.566,3.1383459568; 2492.065,3.154808984; 2492.565,3.1506932272;
            2493.064,3.1671562544; 2493.566,3.1301144432; 2494.065,3.113651416;
            2494.562,3.0848411184; 2495.063,3.1095356592; 2495.564,3.1383459568;
            2496.063,3.1259986864; 2496.566,3.154808984; 2497.067,3.1301144432;
            2497.565,3.1424617136; 2498.063,3.1177671728; 2498.566,3.1259986864;
            2499.063,3.1465774704; 2499.565,3.195966552; 2500.065,3.175387768;
            2500.567,3.1836192816; 2501.063,3.1177671728; 2501.567,3.154808984;
            2502.065,3.1506932272; 2502.566,3.1589247408; 2503.067,3.1177671728;
            2503.565,3.1795035248; 2504.066,3.1424617136; 2504.565,3.1424617136;
            2505.066,3.1506932272; 2505.566,3.1054199024; 2506.064,3.1712720112;
            2506.565,3.1630404976; 2507.066,3.1836192816; 2507.566,3.1836192816;
            2508.067,3.1918507952; 2508.565,3.2124295792; 2509.063,3.2083138224;
            2509.565,3.2330083632; 2510.065,3.2041980656; 2510.567,3.2823974448;
            2511.064,3.2494713904; 2511.565,3.2700501744; 2512.067,3.2700501744;
            2512.566,3.2412398768; 2513.066,3.2618186608; 2513.566,3.3647125808;
            2514.066,3.3359022832; 2514.566,3.3070919856; 2515.066,3.319439256;
            2515.565,3.3029762288; 2516.062,3.3029762288; 2516.563,3.3070919856;
            2517.064,3.257702904; 2517.567,3.2453556336; 2518.067,3.278281688;
            2518.565,3.2247768496; 2519.067,3.2412398768; 2519.566,3.2124295792;
            2520.067,3.2083138224; 2520.565,3.2124295792; 2521.063,3.2041980656;
            2521.564,3.2083138224; 2522.066,3.2412398768; 2522.565,3.2453556336;
            2523.066,3.1630404976; 2523.563,3.216545336; 2524.065,3.1877350384;
            2524.564,3.2206610928; 2525.065,3.1506932272; 2525.567,3.1424617136;
            2526.064,3.1671562544; 2526.566,3.1095356592; 2527.066,3.1424617136;
            2527.566,3.1795035248; 2528.066,3.1342302; 2528.566,3.1465774704;
            2529.066,3.1506932272; 2529.567,3.195966552; 2530.066,3.154808984;
            2530.566,3.1465774704; 2531.066,3.175387768; 2531.564,3.1342302;
            2532.066,3.1589247408; 2532.568,3.175387768; 2533.067,3.175387768;
            2533.566,3.2000823088; 2534.064,3.1506932272; 2534.566,3.2000823088;
            2535.065,3.195966552; 2535.567,3.1918507952; 2536.066,3.1918507952;
            2536.566,3.2041980656; 2537.066,3.1836192816; 2537.566,3.2206610928;
            2538.067,3.2041980656; 2538.566,3.1712720112; 2539.067,3.1589247408;
            2539.567,3.1918507952; 2540.067,3.2247768496; 2540.566,3.1795035248;
            2541.067,3.2000823088; 2541.566,3.1671562544; 2542.067,3.195966552;
            2542.566,3.1795035248; 2543.065,3.1712720112; 2543.566,3.1465774704;
            2544.066,3.1671562544; 2544.568,3.1177671728; 2545.066,3.1506932272;
            2545.566,3.1712720112; 2546.067,3.1465774704; 2546.567,3.1465774704;
            2547.065,3.175387768; 2547.567,3.0971883888; 2548.067,3.1918507952;
            2548.566,3.1259986864; 2549.065,3.1259986864; 2549.565,3.0889568752;
            2550.066,3.1465774704; 2550.565,3.1013041456; 2551.066,3.1218829296;
            2551.566,3.113651416; 2552.067,3.1712720112; 2552.565,3.113651416;
            2553.065,3.154808984; 2553.566,3.1465774704; 2554.072,3.1465774704],
        tableName="Heater",
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents)
        annotation (Placement(transformation(extent={{-54,66},{-34,86}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-116,44},{-96,64}})));
      Modelica.Blocks.Sources.Ramp Heater1(
        height=1.2E3,
        duration=20,
        startTime=10)
        annotation (Placement(transformation(extent={{-26,-72},{-18,-64}})));
      Modelica.Blocks.Sources.Ramp Heater2(
        height=4E3,
        duration=20,
        startTime=350)
        annotation (Placement(transformation(extent={{-26,-54},{-18,-46}})));
      Modelica.Blocks.Sources.Ramp Heater3(
        height=3.8E3,
        duration=20,
        startTime=800)
        annotation (Placement(transformation(extent={{-26,-40},{-18,-32}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=0.6,
        rising=10,
        width=1400,
        falling=10,
        period=2500,
        offset=0.01)
        annotation (Placement(transformation(extent={{-42,-20},{-22,0}})));
    equation
      connect(actuatorBus.TopValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,78},{-3,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,78},{-3,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater1_Power, Heater1.y) annotation (Line(
          points={{30,-100},{30,-68},{-17.6,-68}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater2_Power, Heater2.y) annotation (Line(
          points={{30,-100},{30,-50},{-17.6,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater3_Power, Heater3.y) annotation (Line(
          points={{30,-100},{30,-36},{-17.6,-36}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Pump_Power, trapezoid.y) annotation (Line(
          points={{30,-100},{30,-10},{-21,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end Dynamic_CS;

    model AdaptiveHeating
      extends BaseClasses.CS_Dummy;
      Modelica.Blocks.Sources.Constant const1(k=1)
        annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{-56,-24},{-36,-4}})));
      Modelica.Blocks.Sources.Constant const4(k=20)
        annotation (Placement(transformation(extent={{-56,-54},{-36,-34}})));


    equation
      connect(actuatorBus.TopValve_Opening, const2.y) annotation (Line(
          points={{30,-100},{30,-14},{-35,-14}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, const1.y) annotation (Line(
          points={{30,-100},{30,20},{-35,20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));

      connect(actuatorBus.Pump_Power, const4.y) annotation (Line(
          points={{30,-100},{30,-44},{-35,-44}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

    end AdaptiveHeating;

    model SF_AVO_TVC_CS
      extends RegularCS;
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-72,36},{-52,56}})));
      Modelica.Blocks.Sources.Constant const1(k=20)
        annotation (Placement(transformation(extent={{-70,68},{-50,88}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{-70,-32},{-50,-12}})));
      Modelica.Blocks.Sources.Constant const3(k=0.02)
        annotation (Placement(transformation(extent={{-72,2},{-52,22}})));
    equation
      connect(actuatorBus.Pump_Power, const1.y) annotation (Line(
          points={{30,-100},{30,78},{-49,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-22},{-49,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,46},{-51,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TopValve_Opening, const3.y) annotation (Line(
          points={{30,-100},{30,12},{-51,12}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end SF_AVO_TVC_CS;

    model NF_AVO_CS
      extends RegularCS;
      Modelica.Blocks.Sources.Constant const(k=0.02)
        annotation (Placement(transformation(extent={{-164,26},{-144,46}})));
      Modelica.Blocks.Sources.Constant const1(k=0.02)
        annotation (Placement(transformation(extent={{-144,72},{-124,92}})));
      Modelica.Blocks.Sources.Constant const2(k=0)
        annotation (Placement(transformation(extent={{-70,-32},{-50,-12}})));
      Modelica.Blocks.Sources.Constant const3(k=1)
        annotation (Placement(transformation(extent={{-72,2},{-52,22}})));
      Modelica.Blocks.Sources.Pulse pulse(
        amplitude=8,
        width=20,
        period=500,
        nperiod=1,
        offset=0.02)
        annotation (Placement(transformation(extent={{-72,74},{-52,94}})));
      Modelica.Blocks.Sources.Pulse pulse1(
        amplitude=1,
        width=20,
        period=500,
        nperiod=1,
        offset=0.02)
        annotation (Placement(transformation(extent={{-74,40},{-54,60}})));
    equation
      connect(actuatorBus.TopValve_Opening, const3.y) annotation (Line(
          points={{30,-100},{30,12},{-51,12}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater1_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-22},{-49,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater2_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-22},{-49,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater3_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-22},{-49,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Pump_Power, pulse.y) annotation (Line(
          points={{30,-100},{30,84},{-51,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, pulse1.y) annotation (Line(
          points={{30,-100},{30,50},{-53,50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end NF_AVO_CS;

    model SF_AVO_H1_CS
      extends RegularCS;
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-64,26},{-44,46}})));
      Modelica.Blocks.Sources.Constant const1(k=20)
        annotation (Placement(transformation(extent={{-70,68},{-50,88}})));
      Modelica.Blocks.Sources.Pulse pulse(
        amplitude=3.8E3,
        width=20,
        period=500,
        nperiod=1)
        annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
      Modelica.Blocks.Sources.Pulse pulse1(
        amplitude=3.8E3,
        width=40,
        period=250,
        nperiod=2)
        annotation (Placement(transformation(extent={{-88,-46},{-68,-26}})));
      Modelica.Blocks.Sources.Pulse pulse2(
        amplitude=3.8E3,
        width=60,
        period=100,
        nperiod=5)
        annotation (Placement(transformation(extent={{-84,-78},{-64,-58}})));
    equation
      connect(actuatorBus.TopValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,36},{-43,36}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,36},{-43,36}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Pump_Power, const1.y) annotation (Line(
          points={{30,-100},{30,78},{-49,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater1_Power, pulse.y) annotation (Line(
          points={{30,-100},{30,-8},{-39,-8}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater2_Power, pulse1.y) annotation (Line(
          points={{30,-100},{30,-36},{-67,-36}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater3_Power, pulse2.y) annotation (Line(
          points={{30,-100},{30,-68},{-63,-68}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end SF_AVO_H1_CS;

    model Sequence1
      extends BaseClasses.CS_Dummy;

      Modelica.Blocks.Sources.CombiTimeTable PumpPower(
        tableOnFile=false,
        table=[0.228978543195933,0.141251262373612; 0.818617165443251,
            0.143063415917937; 1.39061038961039,0.145250770135477;
            1.94660511951816,0.147777672735082; 2.48824825898739,
            0.150608471425603; 3.01718671183889,0.15370751391589;
            3.53506738189347,0.157039147914794; 4.04353717297196,
            0.160567721131165; 4.54424298889516,0.164257581273853;
            5.03883173348391,0.16807307605171; 5.52895031055894,
            0.171978553173584; 6.00099999999992,0.177541048758415;
            6.50099999999992,0.17934912358156; 7.00099999999991,
            0.184057687799932; 7.5009999999999,0.187350384570445;
            8.0009999999999,0.191227085031053; 8.50099999999989,
            0.19499090961327; 9.00099999999988,0.197569757200063;
            9.50099999999988,0.197929695857794; 10.0009999999999,
            0.198411862645633; 10.5009999999999,0.201303057100684;
            11.0009999999999,0.203223196411243; 11.5009999999998,
            0.207578639843083; 12.0009999999998,0.213668269591694;
            12.5009999999998,0.219720558042168; 13.0009999999998,
            0.226850044420723; 13.5009999999998,0.23114009980745;
            14.0009999999998,0.235432729809739; 14.5009999999998,
            0.242615715434126; 15.0009999999998,0.24618512241778;
            15.5009999999998,0.25072389106832; 16.0009999999998,
            0.256631848072569; 16.5009999999998,0.26129796077051;
            17.0009999999998,0.26611431180745; 17.5009999999998,
            0.269328909830987; 18.0009999999998,0.274151223998362;
            18.5009999999998,0.275146119879696; 19.0009999999998,
            0.273341474325266; 19.5009999999997,0.271848342312517;
            20.0009999999997,0.271022428620134; 20.5009999999997,
            0.269817886670477; 21.0009999999997,0.266853691368745;
            21.5009999999997,0.265659324601173; 22.0009999999997,
            0.265665280270346; 22.5009999999997,0.262517733570444;
            23.0009999999997,0.258618109962076; 23.5009999999997,
            0.25442565592252; 24.0009999999997,0.250029495629614;
            24.5009999999997,0.245181738047725; 25.0009999999997,
            0.239805118732262; 25.5009999999997,0.23511010898594;
            26.0009999999997,0.231207104231118; 26.5009999999997,
            0.227093592085646; 27.0009999999996,0.221919864395224;
            27.5009999999996,0.219883484779664; 28.0009999999996,
            0.214446610743704; 28.5009999999996,0.208491119151354;
            29.0009999999996,0.202280919472374; 29.5009999999996,
            0.200501747831642; 30.0009999999996,0.195956137431511;
            30.5009999999996,0.194041110270347; 31.0009999999996,
            0.191928314429223; 31.5009999999996,0.1928883816829;
            32.0009999999996,0.19175094134815; 32.5009999999996,
            0.19359293549918; 33.0009999999996,0.194001210526967;
            33.5009999999996,0.195191333771491; 34.0009999999996,
            0.195850055199736; 34.5009999999996,0.198743798184045;
            35.0009999999995,0.197306685490681; 35.5009999999995,
            0.198590976573714; 36.0009999999995,0.19814449989735;
            36.5009999999995,0.197621578714283; 37.0009999999995,
            0.197416124138278; 37.5009999999995,0.198167355685189;
            38.0009999999995,0.195073270928405; 38.5009999999995,
            0.194865313580579; 39.0009999999995,0.194490112507026;
            39.5009999999995,0.193843279932655; 40.0009999999995,
            0.19227540745799; 40.5009999999995,0.19188236936515;
            41.0009999999995,0.188504795165411; 41.5009999999995,
            0.184353103753512; 42.0009999999995,0.17768793812749;
            42.5009999999995,0.174064207515853; 43.0009999999994,
            0.167542481376265; 43.5009999999994,0.16049197788362;
            44.0009999999994,0.156273173470413; 44.5009999999994,
            0.153846346188949; 45.0009999999994,0.152740292033996;
            45.5009999999994,0.152878660854199; 46.0009999999994,
            0.150719183623077; 46.5009999999994,0.153067085709707;
            47.0009999999994,0.152432953424974; 47.5009999999994,
            0.155395448257599; 48.0009999999994,0.157911427130433;
            48.5009999999994,0.161789822888197; 49.0009999999994,
            0.164394925109838; 49.5009999999994,0.166935496470086;
            50.0009999999994,0.170823222142528; 50.5009999999993,
            0.170174709046745; 51.0009999999993,0.17027574108957;
            51.5009999999993,0.169191774041515; 52.0009999999993,
            0.166787838997383; 52.5009999999993,0.165918621273944;
            53.0009999999993,0.163768483146451; 53.5009999999993,
            0.161862807303038; 54.0009999999993,0.16484395008107;
            54.5009999999993,0.165095250845045; 55.0009999999993,
            0.164706468920233; 55.5009999999993,0.163585137336709;
            56.0009999999993,0.16272862907584; 56.5009999999993,
            0.162577532562273; 57.0009999999993,0.159439312015036;
            57.5009999999993,0.160684595389341; 58.0009999999992,
            0.157694118645961; 58.5009999999992,0.157786623166392;
            59.0009999999992,0.156395361435761; 59.5009999999992,
            0.153947280474336; 60.0009999999992,0.152100220610982;
            60.5009999999992,0.149871173303692; 61.0009999999992,
            0.148339856527295; 61.5009999999992,0.146349341065052;
            62.0009999999992,0.145772983894408; 62.5009999999992,
            0.143088064522718; 63.0009999999992,0.14145995935992;
            63.5009999999992,0.141879299177507; 64.0009999999992,
            0.143442909453741; 64.5009999999992,0.140630691138932;
            65.0009999999992,0.142742612047072; 65.5009999999992,
            0.143796018540698; 66.0009999999992,0.144258634700554;
            66.5009999999991,0.146381574594964; 67.0009999999991,
            0.147811876652172; 67.5009999999991,0.150910168567504;
            68.0009999999991,0.154297886603463; 68.5009999999991,
            0.159505544318403; 69.0009999999991,0.1619799198372;
            69.5009999999991,0.160834827005555; 70.0009999999991,
            0.163625001781953; 70.5009999999991,0.165175837899311;
            71.0009999999991,0.167549164692054; 71.5009999999991,
            0.172026003859756; 72.0009999999991,0.176638633652172;
            72.5009999999991,0.177832140373649; 73.0009999999991,
            0.180622327912387; 73.5009999999991,0.185119592697611;
            74.000999999999,0.186116140619481; 74.500999999999,
            0.185448938003267; 75.000999999999,0.187189108328536;
            75.500999999999,0.184562764900946; 76.000999999999,
            0.185588197487412; 76.500999999999,0.186183243021246;
            77.000999999999,0.184604443697284; 77.500999999999,
            0.185230910896369; 78.000999999999,0.184181727664594;
            78.500999999999,0.182276955024515; 79.000999999999,
            0.180076710130759; 79.500999999999,0.176739898167373;
            80.000999999999,0.177818766693362; 80.500999999999,
            0.179734602914349; 81.000999999999,0.180837231670805;
            81.500999999999,0.183381236615231; 82.0009999999989,
            0.183710575087281; 82.5009999999989,0.18562895946649;
            83.0009999999989,0.185763893307941; 83.5009999999989,
            0.187532027408628; 84.0009999999989,0.184752002966653;
            84.5009999999989,0.185376764122587; 85.0009999999989,
            0.187203492431184; 85.5009999999989,0.187241676632884;
            86.0009999999989,0.185361497233407; 86.5009999999989,
            0.18395751206734; 87.0009999999989,0.180152997532525;
            87.5009999999989,0.177586106330171; 88.0009999999989,
            0.17404980458058; 88.5009999999989,0.17036581899444;
            89.0009999999988,0.166549399909118; 89.5009999999988,
            0.162831496749262; 90.0009999999988,0.158389476068975;
            90.5009999999988,0.155793710096435; 91.0009999999988,
            0.152390667422031; 91.5009999999988,0.151791379316441;
            92.0009999999988,0.150451898394571; 92.5009999999988,
            0.150114047098723; 93.0009999999988,0.147286535617847;
            93.5009999999988,0.14804538873259; 94.0009999999988,
            0.148672662518468; 94.5009999999988,0.151835484228504;
            95.0009999999988,0.152615522451126; 95.5009999999988,
            0.157049047151681; 96.0009999999988,0.157215404041842;
            96.5009999999988,0.15822551658483; 97.0009999999987,
            0.157245957381168; 97.5009999999987,0.155966760718207;
            98.0009999999987,0.15903533374632; 98.5009999999987,
            0.159929203709707; 99.0009999999987,0.163047897150374;
            99.5009999999987,0.163520723383783; 100.000999999999,
            0.163228701604117; 100.500999999999,0.168100246634519;
            101.000999999999,0.1720312638287; 101.500999999999,
            0.175993738485777; 102.000999999999,0.178681193040534;
            102.500999999999,0.184848951643018; 103.000999999999,
            0.192797576968942; 103.500999999999,0.203654338452433;
            104.000999999999,0.214109598355996; 104.500999999999,
            0.224533482097415; 105.000999999999,0.234919124702841;
            105.500999999999,0.246886219697937; 106.000999999999,
            0.252536163461259; 106.500999999999,0.258637672228503;
            107.000999999999,0.262690942386724; 107.500999999999,
            0.264185748010131; 108.000999999999,0.266391898053282;
            108.500999999999,0.263562672476623; 109.000999999999,
            0.260298845670477; 109.500999999999,0.253241505640402;
            110.000999999999,0.247289378437068; 110.500999999999,
            0.240830479365149; 111.000999999999,0.231931129722128;
            111.500999999999,0.222544567206274; 112.000999999999,
            0.214774182116702; 112.500999999999,0.209737119581233;
            113.000999999999,0.203678853610654; 113.500999999999,
            0.200088196340632; 114.000999999999,0.193426436241253;
            114.500999999999,0.188279881614577; 115.000999999999,
            0.182849769693688; 115.500999999999,0.176105676177834;
            116.000999999998,0.168579746628308; 116.500999999998,
            0.161394231855506; 117.000999999998,0.155129743996075;
            117.500999999998,0.152838664350112; 118.000999999998,
            0.154195997769204; 118.500999999998,0.155268948050668;
            119.000999999998,0.159829839400456; 119.500999999998,
            0.163771916284078; 120.000999999998,0.169718963051322;
            120.500999999998,0.174451289074532; 121.000999999998,
            0.180277791862371; 121.500999999998,0.18422583583295;
            122.000999999998,0.187864001203659; 122.500999999998,
            0.190998813372015; 123.000999999998,0.189758656062436;
            123.500999999998,0.188903867010785; 124.000999999998,
            0.185675718527948; 124.500999999998,0.181570680155931;
            125.000999999998,0.175456374592021; 125.500999999998,
            0.168140135393264; 126.000999999998,0.164102981320691;
            126.500999999998,0.161000425430531; 127.000999999998,
            0.160778833655114; 127.500999999998,0.162237108346189;
            128.000999999998,0.163709868557696; 128.500999999998,
            0.164502682982999; 129.000999999998,0.16899137291631;
            129.500999999998,0.171791745165084; 130.000999999998,
            0.174619257261194; 130.500999999998,0.173591323534486;
            131.000999999998,0.172194138289308; 131.500999999998,
            0.170357270565215; 132.000999999998,0.168028018293231;
            132.500999999998,0.168169806665902; 133.000999999998,
            0.16640845168617; 133.500999999998,0.165784561281462;
            134.000999999998,0.166345670033342; 134.500999999998,
            0.164890730119645; 135.000999999998,0.166739508447203;
            135.500999999998,0.169289480427589; 136.000999999998,
            0.172068622762011; 136.500999999998,0.176017458213793;
            137.000999999998,0.180776122626673; 137.500999999998,
            0.187246932286039; 138.000999999998,0.194184600872505;
            138.500999999998,0.200077338678977; 139.000999999998,
            0.208166877214773; 139.500999999998,0.214355863092184;
            140.000999999998,0.221871553888523; 140.500999999998,
            0.228228566629941; 141.000999999998,0.237032824628307;
            141.500999999998,0.247189298875119; 142.000999999998,
            0.25446644045472; 142.500999999998,0.262383664578617;
            143.000999999998,0.267920710117682; 143.500999999998,
            0.270468087384763; 144.000999999998,0.27301291630271;
            144.500999999998,0.272685235651517; 145.000999999998,
            0.273288753903887; 145.500999999998,0.272109709255309;
            146.000999999998,0.269367045287672; 146.500999999998,
            0.266037886190255; 147.000999999998,0.259080741341938;
            147.500999999998,0.250835023081396; 148.000999999998,
            0.241793063434126; 148.500999999998,0.233100866860082;
            149.000999999998,0.226709884280808; 149.500999999998,
            0.220537059901272; 150.000999999998,0.21745234462275;
            150.500999999998,0.213315894477277; 151.000999999998,
            0.208933283208562; 151.500999999998,0.206585360528928;
            152.000999999998,0.202699336023861; 152.500999999998,
            0.199668135782933; 153.000999999998,0.196516369143508;
            153.500999999998,0.192531847456356; 154.000999999998,
            0.189138994467797; 154.500999999998,0.187689985252368;
            155.000999999998,0.18524699625106; 155.500999999998,
            0.180293130834257; 156.000999999998,0.175345170610982;
            156.500999999998,0.168374442865967; 157.000999999998,
            0.163088643664921; 157.500999999998,0.160594720455376;
            158.000999999998,0.158390220351093; 158.500999999998,
            0.154291993984634; 159.000999999998,0.149719242546582;
            159.500999999998,0.150393221146778; 160.000999999998,
            0.148633519848968; 160.500999999998,0.149721702932983;
            161.000999999998,0.151809024164431; 161.500999999998,
            0.158502196520756; 162.000999999998,0.16514361338313;
            162.500999999998,0.174873971491989; 163.000999999998,
            0.181889704496565; 163.500999999998,0.189783140830988;
            164.000999999998,0.196511965465836; 164.500999999998,
            0.205912986560638; 165.000999999998,0.209800738734551;
            165.500999999998,0.213321749111472; 166.000999999998,
            0.218543020369726; 166.500999999998,0.220788242245829;
            167.000999999998,0.223275358671131; 167.500999999998,
            0.223559701063743; 168.000999999998,0.218497117501795;
            168.500999999998,0.212169814581233; 169.000999999998,
            0.207372966610001; 169.500999999998,0.203795054527948;
            170.000999999998,0.198943873251714; 170.500999999998,
            0.196263253837853; 171.000999999998,0.192788945332459;
            171.500944099377,0.192524942759069; 172.000975155277,
            0.190021714551812; 172.501002942136,0.189495421690092;
            173.001027459952,0.184280953594309; 173.501048708726,
            0.180841422881658; 174.001066688458,0.178210839883293;
            174.501081399148,0.176408750049033; 175.001092840795,
            0.172529525817912; 175.501101013401,0.16958064811376;
            176.001105916964,0.167248897790452; 176.501107551485,
            0.162426556372015; 177.001105916964,0.158717069780645;
            177.501101013401,0.154786016246157; 178.001092840795,
            0.150584221827066; 178.501081399148,0.148338175765935;
            179.001066688458,0.147295781918272; 179.501048708726,
            0.14633148515822; 180.001027459952,0.146795826148413;
            180.501002942136,0.14790358057633; 181.000975155277,
            0.148773647423012; 181.500944099377,0.153157924452107;
            182.000999999998,0.153687610697285; 182.500999999998,
            0.156083057526968; 183.000999999998,0.157718769165085;
            183.500999999998,0.158995430444588; 184.000999999998,
            0.162855149808432; 184.500999999998,0.164260005314807;
            185.000999999998,0.167388011226869; 185.500999999998,
            0.170443880045437; 186.000999999998,0.169708742501469;
            186.500999999998,0.16686166156783; 187.000999999998,
            0.166028094395225; 187.500999999998,0.163771016769857;
            188.000999999998,0.163750679262829; 188.500999999998,
            0.164231976312191; 189.000999999998,0.165596934754166;
            189.500999999998,0.168806446775088; 190.000999999998,
            0.171250312531544; 190.500999999998,0.175056574698265;
            191.000999999998,0.175981846587118; 191.500999999998,
            0.181922096614251; 192.000999999998,0.186576364069628;
            192.500999999998,0.191659293927752; 193.000999999998,
            0.197645372738474; 193.500999999997,0.202479558093819;
            194.000999999997,0.210052966258578; 194.500999999997,
            0.216070424289634; 195.000999999997,0.224239731366457;
            195.500999999997,0.231757990346842; 196.000999999997,
            0.236052273565541; 196.500999999997,0.241599497192217;
            197.000999999997,0.248446304305652; 197.500999999997,
            0.254759211191563; 198.000999999997,0.262094963288653;
            198.500999999997,0.266660923952922; 199.000999999997,
            0.270086898864985; 199.500999999997,0.273204727900618;
            200.000999999997,0.271906854221311; 200.500999999997,
            0.272697156164429; 201.000999999997,0.271555428915655;
            201.500999999997,0.270844113023861; 202.000999999997,
            0.266689019612942; 202.500999999997,0.261656194376263;
            203.000999999997,0.25554872164269; 203.500999999997,
            0.248682375796662; 204.000999999997,0.242866040184044;
            204.500999999997,0.239723612401762; 205.000999999997,
            0.236152516007189; 205.500999999997,0.231224920286365;
            206.000999999997,0.225664106580906; 206.500999999997,
            0.222197401228176; 207.000999999997,0.216722329549523;
            207.500999999997,0.21429464963223; 208.000999999997,
            0.209730375010458; 208.500999999997,0.205342686198428;
            209.000999999997,0.201464304262828; 209.500999999997,
            0.199365078721475; 210.000999999997,0.197264172074205;
            210.500999999997,0.195416204542985; 211.000999999997,
            0.192329758653479; 211.500999999997,0.18864744925531;
            212.000999999997,0.185361539740436; 212.500999999997,
            0.184296248508334; 213.000999999997,0.181779413051975;
            213.500999999997,0.178112380490027; 214.000999999997,
            0.1760420094253; 214.500999999997,0.174271350922848;
            215.000999999997,0.170080576769203; 215.500999999997,
            0.165602897325268; 216.000999999997,0.163513893570446;
            216.500999999997,0.162536884599867; 217.000999999997,
            0.159454740080743; 217.500999999997,0.159280695403071;
            218.000999999997,0.157803686115722; 218.500999999997,
            0.158573577787837; 219.000999999997,0.160118464274597;
            219.500999999997,0.161684571184699; 220.000999999997,
            0.162752420461914; 220.500999999997,0.161591156263483;
            221.000999999997,0.161989267192871; 221.500999999997,
            0.160730430546255; 222.000999999997,0.159808600044457;
            222.500999999997,0.159964812437396; 223.000999999997,
            0.158637184549197; 223.500999999997,0.154358139655114;
            224.000999999997,0.154645899346516; 224.500999999997,
            0.154759682666229; 225.000999999997,0.158155102499508;
            225.500999999997,0.162722782767242; 226.000999999997,
            0.170792803030727; 226.500999999997,0.176750877853218;
            227.000999999997,0.185262258839161; 227.500999999997,
            0.193246532027131; 228.000999999997,0.201419267174564;
            228.500999999997,0.208025000546581; 229.000999999997,
            0.21408155564596; 229.500999999997,0.218121234148412;
            230.000999999997,0.219113534870216; 230.500999999997,
            0.217770636085973; 231.000999999997,0.214918503873812;
            231.500999999997,0.211366904606731; 232.000999999997,
            0.207474927056879; 232.500999999997,0.202840206331478;
            233.000999999997,0.195674179099049; 233.500999999997,
            0.190166830244849; 234.000999999997,0.187858828067667;
            234.500999999997,0.185430273857467; 235.000999999997,
            0.183595926801567; 235.500999999997,0.181608775999344;
            236.000999999997,0.181180085098723; 236.500999999997,
            0.178347458148739; 237.000999999997,0.177348372822489;
            237.500999999997,0.173520968998363; 238.000999999997,
            0.171646712578618; 238.500999999997,0.169513599627327;
            239.000999999997,0.166001934771165; 239.500999999997,
            0.162014035261194; 240.000999999997,0.159463232911407;
            240.500999999997,0.154514445266752; 241.000999999997,
            0.152489918697939; 241.500999999997,0.153665582830008;
            242.000999999997,0.153690227934617; 242.500999999997,
            0.15202221245276; 243.000999999997,0.150152176589406;
            243.500944099376,0.148651417723437; 244.000975155276,
            0.149199780969596; 244.501002942135,0.147172699665248;
            245.001027459951,0.147280483595291; 245.501048708725,
            0.149187843051976; 246.001066688457,0.152892198053937;
            246.501081399147,0.154857293191237; 247.001092840794,
            0.158646545238638; 247.5011010134,0.158153369121933;
            248.001105916963,0.16024663426381; 248.501107551484,
            0.157847804797317; 249.001105916963,0.156259581587445;
            249.5011010134,0.157805301842757; 250.001092840794,
            0.160736365693689; 250.501081399147,0.162574976390322;
            251.001066688457,0.165803134742397; 251.501048708725,
            0.169303816308922; 252.001027459951,0.169319105360246;
            252.501002942135,0.17226032935567; 253.000975155276,
            0.175801762841122; 253.500944099376,0.177777039790779;
            254.000999999997,0.183224079193852; 254.500999999997,
            0.189402839699246; 255.000999999997,0.200971798170641;
            255.500999999997,0.213685899935924; 256.000999999997,
            0.22878440256358; 256.500999999997,0.238997786102318;
            257.000999999997,0.249652583692053; 257.500999999997,
            0.254387512112452; 258.000999999997,0.261085812491334;
            258.500999999997,0.267102476670477; 259.000999999997,
            0.271042841057532; 259.500999999997,0.274189534552791;
            260.000999999997,0.275326131156257; 260.500999999997,
            0.273866970604769; 261.000999999997,0.267122019124874;
            261.500999999997,0.263715588736185; 262.000999999997,
            0.255454565221311; 262.500999999997,0.250521022245175;
            263.000999999997,0.241095398764299; 263.500999999997,
            0.232572915120952; 264.000999999997,0.226604590342593;
            264.500999999997,0.221832338562926; 265.000999999997,
            0.21770350328898; 265.500999999997,0.214944728128471;
            266.000999999997,0.211079918491661; 266.500999999997,
            0.204436007768549; 267.000999999997,0.20093197929748;
            267.500999999997,0.196525591000324; 268.000999999997,
            0.191969794229811; 268.500999999997,0.18717125795325;
            269.000999999996,0.179655556210197; 269.500999999996,
            0.175371421186987; 270.000999999996,0.171025287627327;
            270.500999999996,0.165274348220331; 271.000999999996,
            0.159379963574369; 271.500999999996,0.157080436662306;
            272.000999999996,0.150534979513891; 272.500999999997,
            0.146894272299442; 273.000999999996,0.143179715639423;
            273.500999999996,0.141500674182411; 274.000999999996,
            0.137687618667864; 274.500999999996,0.139937912156912;
            275.000999999996,0.143321411711015; 275.500999999996,
            0.149560484319383; 276.000999999996,0.156161168834584;
            276.500999999996,0.163350943430204; 277.000999999996,
            0.173067691744032; 277.500999999996,0.179495164597579;
            278.000999999996,0.184143470762665; 278.500999999996,
            0.190715268605751; 279.000999999996,0.19648662712324;
            279.500999999996,0.199865877051648; 280.000999999996,
            0.200912482842103; 280.500999999996,0.204061709192217;
            281.000999999996,0.203410662265444; 281.500999999996,
            0.202235871657402; 282.000999999996,0.196975559863025;
            282.500999999996,0.192268656429223; 283.000999999996,
            0.185877653453087; 283.500999999996,0.178664983582214;
            284.000999999996,0.171800345829681; 284.500999999996,
            0.169630698483816; 285.000999999996,0.163793158506372;
            285.500999999996,0.161161727823143; 286.000999999996,
            0.159025157217062; 286.500999999996,0.155849586288001;
            287.000999999996,0.153426955603136; 287.500999999996,
            0.150936451523372; 288.000999999996,0.149210772160835;
            288.500999999996,0.149546898782607; 289.000999999996,
            0.148646298836873; 289.500999999996,0.148654773449491;
            290.000999999996,0.150978043673094; 290.500999999996,
            0.156378417359266; 291.000999999996,0.156609329257272;
            291.500999999996,0.158825667591041; 292.000999999996,
            0.162056349980057; 292.500999999996,0.162426423501142;
            293.000999999996,0.163611445939194; 293.500999999996,
            0.164129266175872; 294.000999999996,0.164139440157566;
            294.500999999996,0.166154590059821; 295.000999999996,
            0.167935453669498; 295.500999999996,0.166403281158219;
            296.000999999996,0.166551838184699; 296.500999999996,
            0.165250524032688; 297.000999999996,0.164745478950308;
            297.500999999996,0.167163034332133; 298.000999999996,
            0.168391327709707; 298.500999999996,0.170751127740763;
            299.000999999996,0.173104152067013; 299.500999999996,
            0.174418138526967; 300.000999999996,0.175356091509641;
            300.500999999996,0.176198998852237; 301.000999999996,
            0.177022367894081; 301.500999999996,0.178275233439684;
            302.000999999996,0.179072296735205; 302.500999999996,
            0.177765108272963; 303.000999999996,0.179056245417454;
            303.500999999996,0.179258269957173; 304.000999999996,
            0.178218434795356; 304.500999999996,0.17860296335665;
            305.000999999996,0.175078547670151; 305.500999999996,
            0.170657741221966; 306.000999999996,0.170786771318403;
            306.500999999996,0.169450653373976; 307.000999999996,
            0.169079750161488; 307.500999999996,0.170636564918926;
            308.000999999996,0.169677358031708; 308.500999999996,
            0.170492253549524; 309.000999999996,0.171801155939847;
            309.500999999996,0.170922575208236; 310.000999999996,
            0.17391222138313; 310.500999999996,0.176332283697611;
            311.000999999996,0.178534216023862; 311.500999999996,
            0.179090223949328; 312.000999999996,0.180168293671459;
            312.500999999996,0.180316877128144; 313.000999999996,
            0.180698041550831; 313.500999999996,0.183114746400128;
            314.000999999996,0.181835571416801; 314.500944099375,
            0.181186215717225; 315.000975155275,0.179883235014381;
            315.500947041513,0.179388342519775; 316.00100261523,
            0.177550584845699; 316.501051650862,0.17658033427329;
            317.00109414841,0.175857119538082; 317.501130107874,
            0.17429692464596; 318.001159529254,0.172347927273617;
            318.501182412549,0.171333532284731; 319.00119875776,
            0.170318277006536; 319.501208564886,0.167120649511603;
            320.001211833928,0.16657313386041; 320.501208564886,
            0.162708344829354; 321.00119875776,0.158835922895062;
            321.501182412549,0.157112738074205; 322.001159529254,
            0.154050115810394; 322.501130107874,0.151749745497219;
            323.00109414841,0.151636006330171; 323.501051650862,
            0.150136102143836; 324.001002615229,0.14728483367669;
            324.500947041513,0.146977549107876; 325.000975155275,
            0.146893479727033; 325.500944099375,0.147429928273617;
            326.000999999996,0.146927418965673; 326.500999999996,
            0.148068249516834; 327.000999999996,0.14929314009905;
            327.500999999996,0.149717562902907; 328.000999999996,
            0.152015376197121; 328.500999999996,0.152034042886889;
            329.000999999996,0.155649290827393; 329.500999999996,
            0.156504931426608; 330.000999999996,0.159122768026477;
            330.500999999996,0.162317836817912; 331.000999999996,
            0.16461482888885; 331.500999999996,0.169145969033996;
            332.000999999996,0.171560103491662; 332.500999999996,
            0.175454587774761; 333.000999999996,0.178680182716899;
            333.500999999996,0.182882837404378; 334.000999999996,
            0.191366286093819; 334.500999999996,0.197292106208889;
            335.000999999996,0.202995519288327; 335.500999999996,
            0.207431630074858; 336.000999999996,0.206946107244195;
            336.500999999996,0.208108164587444; 337.000999999996,
            0.207420638638768; 337.500999999996,0.204341019371034;
            338.000999999996,0.20130381770611; 338.500999999996,
            0.195427247745666; 339.000999999996,0.188908083185025;
            339.500999999996,0.17851135460804; 340.000999999996,
            0.170994782338997; 340.500999999996,0.163001177003921;
            341.000999999996,0.154247846884601; 341.500999999996,
            0.149018906265117; 342.000999999996,0.142669506174565;
            342.500999999996,0.138817405867929; 343.000999999995,
            0.136072234122914; 343.500999999996,0.139165471507354;
            344.000999999995,0.140974393351747; 344.500999999995,
            0.140852149578946; 345.000999999995,0.14303711011703;
            345.500999999995,0.144494605503431; 346.000999999995,
            0.144856203636808; 346.500999999995,0.147910381637461;
            347.000999999995,0.150285500275251; 347.500999999995,
            0.15304508064923; 348.000999999995,0.156777455798952;
            348.500999999995,0.160752660803202; 349.000999999995,
            0.163087848423012; 349.500999999995,0.168848990226216;
            350.000999999995,0.174876669870871; 350.500999999995,
            0.177062447768876; 351.000999999995,0.179958687611635;
            351.500999999995,0.185669751569138; 352.000999999995,
            0.188401373878716; 352.500999999995,0.190698325026477;
            353.000999999995,0.189482769244195; 353.500999999995,
            0.19313112635142; 354.000999999995,0.191853578966326;
            354.500999999995,0.192047103147104; 355.000999999995,
            0.191188918036611; 355.500999999995,0.191677854013074;
            356.000999999995,0.19280429381072; 356.500999999995,
            0.194210005983979; 357.000999999995,0.19360478047074;
            357.500999999995,0.195801588949327; 358.000999999995,
            0.197995909879043; 358.500999999995,0.202379424333767;
            359.000999999995,0.205485363192871; 359.500999999995,
            0.209249162996728; 360.000999999995,0.207947888721802;
            360.500999999995,0.209011499924809; 361.000999999995,
            0.210596298299115; 361.500999999995,0.214251451371687;
            362.000999999995,0.215556952185679; 362.500999999995,
            0.214242060672439; 363.000999999995,0.213523942438049;
            363.500999999995,0.215202947135009; 364.000999999995,
            0.214503472520429; 364.500999999995,0.215231753824123;
            365.000999999995,0.213169880683881; 365.500999999995,
            0.213282771533178; 366.000999999995,0.212457726521083;
            366.500999999995,0.211636883369399; 367.000999999995,
            0.207763591119644; 367.500999999995,0.207461418281789;
            368.000999999995,0.205335912429876; 368.500999999995,
            0.20428588195325; 369.000999999995,0.204036302899311;
            369.500999999995,0.202809732222946; 370.000999999995,
            0.200536501143508; 370.500999999995,0.200434629509641;
            371.000999999995,0.198682619229811; 371.500999999995,
            0.202524530054917; 372.000999999995,0.203499869912387;
            372.500999999995,0.201113780929386; 373.000999999995,
            0.200155402561946; 373.500999999995,0.199045939854198;
            374.000999999995,0.19766569589735; 374.500999999995,
            0.197233598459625; 375.000999999995,0.197012051949981;
            375.500999999995,0.198631684834911; 376.000999999995,
            0.198540063081397; 376.500999999995,0.197251501932001;
            377.000999999995,0.192694017277539; 377.500999999995,
            0.191475929221639; 378.000999999995,0.191751782439357;
            378.500999999995,0.191203427434453; 379.000999999995,
            0.1919223958846; 379.500999999995,0.190534491206274;
            380.000999999995,0.188416591223927; 380.500999999995,
            0.182877847743051; 381.000999999995,0.179279601249752;
            381.500999999995,0.176306064579272; 382.000999999995,
            0.171471845404705; 382.500999999995,0.16868586670088;
            383.000999999995,0.164461941687151; 383.500999999995,
            0.162142893967961; 384.000999999995,0.159323837040534;
            384.500999999995,0.157895238728014; 385.000999999995,
            0.157519226689112; 385.500999999995,0.155336866853545;
            386.000999999995,0.151770871968288; 386.500999999995,
            0.151210647833931; 387.000999999995,0.151038363613924;
            387.500999999995,0.15211132131873; 388.000999999995,
            0.152871907041515; 388.500999999995,0.15391771275907;
            389.000999999995,0.154459263597252; 389.500999999995,
            0.152396571179795; 390.000999999995,0.14982798828702;
            390.500999999995,0.144547305189603; 391.000999999995,
            0.142463377767896; 391.500999999995,0.141853870402417;
            392.000999999995,0.142666182507353; 392.500999999995,
            0.141990444236023; 393.001,0.13982291986594; 393.501,
            0.138318196957344; 394.001,0.137777695820965; 394.501,
            0.138502836767531; 395.001,0.140795040107769; 395.501,
            0.144955726152407; 396.001,0.151286315212171; 396.501,
            0.160088227597789; 397.001,0.171662883619988; 397.501,
            0.186311703589497],
        tableName="pump",
        fileName=
            "C:/Users/Fancy/OneDrive - University of Tennessee/Homework/Engineering/Nuclear/Research/INLDT/Experimental/Experimental Data/Dymola_Inputs/AVO_3H_PumpInput.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents)
        annotation (Placement(transformation(extent={{-38,-24},{-18,-4}})));

      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-42,44},{-22,64}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-38,-70},{-18,-50}})));
      Modelica.Blocks.Sources.Constant const2(k=0.3)
        annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
    equation
      connect(actuatorBus.Heater1_Power, const1.y) annotation (Line(
          points={{30,-100},{30,-60},{-17,-60}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater2_Power, const1.y) annotation (Line(
          points={{30,-100},{30,-60},{-17,-60}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater3_Power, const1.y) annotation (Line(
          points={{30,-100},{30,-60},{-17,-60}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,54},{-21,54}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.TopValve_Opening, const.y) annotation (Line(
          points={{30,-100},{30,54},{-21,54}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Pump_Power, const2.y) annotation (Line(
          points={{30,-100},{30,8},{-9,8}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end Sequence1;

    model RealisticHeaterCS
      extends BaseClasses.CS_Dummy;

    end RealisticHeaterCS;

    model Sequence2_Testing
      extends BaseClasses.CS_Dummy;

      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=0.5,
        rising=15,
        width=2475 - 60,
        falling=15,
        offset=0.05,
        startTime=60)
        annotation (Placement(transformation(extent={{-84,-42},{-64,-22}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-72,22},{-52,42}})));
      Modelica.Blocks.Sources.Constant const1(k=1)
        annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
      Modelica.Blocks.Sources.Constant const2(k=0.55)
        annotation (Placement(transformation(extent={{-30,-42},{-10,-22}})));
    equation
      connect(actuatorBus.TopValve_Opening, const1.y) annotation (Line(
          points={{30,-100},{30,70},{-41,70}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.BotValve_Opening, const1.y) annotation (Line(
          points={{30,-100},{30,70},{-41,70}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.Heater1_Power, const.y) annotation (Line(
          points={{30,-100},{30,32},{-51,32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.Heater2_Power, const.y) annotation (Line(
          points={{30,-100},{30,32},{-51,32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Heater3_Power, const.y) annotation (Line(
          points={{30,-100},{30,32},{-51,32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Pump_Power, const2.y) annotation (Line(
          points={{30,-100},{30,-32},{-9,-32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end Sequence2_Testing;
  end ControlSystems;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;
    model Data_NCFL
      extends NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Record_Data;

      //System Constants
      parameter Modelica.Units.SI.Length Slant = 0.3302 annotation(Dialog(tab="System", group = "Geometry"));
      parameter Modelica.Units.SI.Length Height = 7.1628 annotation(Dialog(tab="System", group = "Geometry"));
      parameter Modelica.Units.SI.Length Width = 0.6223 annotation(Dialog(tab="System", group = "Geometry"));

      //pipe dimensions
      parameter Modelica.Units.SI.Length Pipe_D = 0.0508 annotation(Dialog(tab="System", group = "Piping"));
      parameter Modelica.Units.SI.Length Slant_Pipe_L = sqrt(Width^2+Slant^2) annotation(Dialog(tab="System", group = "Piping"));

      //Jet Pump
      parameter Modelica.Units.SI.Length JetPump_D = 0.0254 annotation(Dialog(tab="Components",group="Jet Pump"));
      parameter Modelica.Units.SI.Length JetPump_L = 0.365125 annotation(Dialog(tab="Components",group="Jet Pump"));

      //Hydraulics
      parameter Modelica.Units.SI.Pressure Init_P = 101325 annotation(Dialog(tab="System", group="Hydraulics"));
      parameter Modelica.Units.SI.Temperature Init_T = 294.15 annotation(Dialog(tab="System", group="Hydraulics"));

      //Heaters
      parameter Modelica.Units.SI.Power Heater_Power = 5.5E3 annotation(Dialog(tab="Components", group="Heaters"));
      parameter Modelica.Units.SI.Length Heater_Length = 0.381 annotation(Dialog(tab="Components", group="Heaters"));
      parameter Modelica.Units.SI.Length Heater_radius = 0.0508 annotation(Dialog(tab="Components", group="Heaters"));

      //Pump
      parameter Modelica.Units.SI.MassFlowRate Pump_Mflow = 20 annotation(Dialog(tab="Components", group="Pump"));

      //HX
      parameter Modelica.Units.SI.Length HX_L = 0.4699 annotation(Dialog(tab="Components", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Length HX_radius = 0.0381 annotation(Dialog(tab="Components", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Power HX_Transfer = 0 annotation(Dialog(tab="Components", group="Heat Exchanger"));
      parameter Real Thermal_Cond = 35 annotation(Dialog(tab="Components", group="Heat Exchanger"));

      //Secondary Loop
      parameter Modelica.Units.SI.Temperature sec_T annotation(Dialog(tab="System", group="Secondary Loop"));
      parameter Modelica.Units.SI.MassFlowRate sec_Mflow = 0 annotation(Dialog(tab="System", group="Secondary Loop"));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Data_NCFL;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    partial model Partial_ControlSystem

      //extends NHES.Systems.BaseClasses.Partial_ControlSystem;
      extends Partial_ControlSystem_Master;

      NHES.Systems.EnergyStorage.PCM_HITB.BaseClasses.SignalSubBus_ActuatorInput
        actuatorBus annotation (Placement(transformation(extent={{10,-120},{50,
                -80}}), iconTransformation(extent={{10,-120},{50,-80}})));
      NHES.Systems.EnergyStorage.PCM_HITB.BaseClasses.SignalSubBus_SensorOutput
        sensorBus annotation (Placement(transformation(extent={{-50,-120},{-10,
                -80}}), iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_SubSystem_A

      import Modelica.Constants;

      extends
        NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.Partial_SubSystem;
      extends
        NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.Record_SubSystem_A;

      Modelica.Fluid.Interfaces.FluidPort_a port_a
        annotation (Placement(transformation(extent={{94,-16},{114,4}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b
        annotation (Placement(transformation(extent={{94,50},{114,70}})));
      annotation (
        defaultComponentName="PHS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));

    end Partial_SubSystem_A;

    partial model Partial_SubSystem
      import NHES;
    replaceable package Medium = Modelica.Media.Water.StandardWater                             annotation (
         choicesAllMatching=true);

     replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
          Placement(transformation(extent={{-18,122},{-2,138}})));
      replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
          Placement(transformation(extent={{2,122},{18,138}})));
      replaceable Data_NCFL data
        annotation (Placement(transformation(extent={{42,122},{58,138}})));

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      SignalSubBus_SensorOutput sensorBus
         annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
            iconTransformation(extent={{-50,80},{-10,120}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a
        annotation (Placement(transformation(extent={{94,-16},{114,4}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b
        annotation (Placement(transformation(extent={{94,50},{114,70}})));
    equation
      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (
        defaultComponentName="PHS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));
    end Partial_SubSystem;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    model ED_Dummy

      extends
        NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.Partial_EventDriver;

      extends NHES.Icons.DummyIcon;

    equation

    annotation(defaultComponentName="PHS_CS");
    end ED_Dummy;

    partial model CS_Dummy
      extends BaseClasses.Partial_ControlSystem;
      extends NHES.Icons.DummyIcon;
    end CS_Dummy;

    partial model Partial_EventDriver

      extends NHES.Systems.BaseClasses.Partial_EventDriver;

      NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.SignalSubBus_ActuatorInput
        actuatorBus annotation (Placement(transformation(extent={{10,-120},{50,
                -80}}), iconTransformation(extent={{10,-120},{50,-80}})));
      NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses.SignalSubBus_SensorOutput
        sensorBus annotation (Placement(transformation(extent={{-50,-120},{-10,
                -80}}), iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;

    partial model Partial_ControlSystem_Master

      annotation (
        defaultComponentName="CS",
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={Bitmap(extent={{-100,-100},{100,100}}, fileName=
                  "modelica://NHES/Resources/Images/Systems/controlSystem.jpg"),
                      Text(
              extent={{-94,-76},{94,-84}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Control System")}));
    end Partial_ControlSystem_Master;
  end BaseClasses;
  annotation (uses(TRANSFORM(version="1.0"), Modelica(version="4.0.0"),
      NHES(version="2")));
end INL_DT;

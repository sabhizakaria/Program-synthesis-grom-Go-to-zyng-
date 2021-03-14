<project xmlns="com.autoesl.autopilot.project" name="multi_chan_2hls" top="communication">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" clean="true" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="../../tb_com_chan_axis.cpp" sc="0" tb="1" cflags=" -Wno-unknown-pragmas" csimflags=" -Wno-unknown-pragmas" blackbox="false"/>
        <file name="com_chan_axis.cpp" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
        <file name="com_chan_axis.h" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="solution1" status="active"/>
    </solutions>
</project>


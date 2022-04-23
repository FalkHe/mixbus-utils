-- based on https://github.com/Ardour/ardour/blob/master/share/scripts/_midi_rec_start.lua
-- and https://github.com/Ardour/ardour/blob/master/share/scripts/_midi_rewrite.lua

ardour {
    ["type"]    = "Session",
    name        = "MIDI Program Change Jump To Marker",
    category    = "MIDI Controls",
    license     = "MIT",
    author      = "FalkHe",
    description = [[An script to map Midi PC Commands to Track Markers ]]
}

function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
end

function jumpToMarker(nr)
    Session:request_stop();
    for loc in Session:locations():list():iter() do
        if loc:is_mark() then
            if string.starts(loc:name(), "PC-"..nr.." |") then -- aka "Marker Number XY"
                -- jump to marker starting with "PC-1 |"
                Session:request_locate(loc:start())
                return
            end
        end
    end
end

function factory ()
    return function (n_samples)
        if Session:actively_recording() then return end -- when recording already, do nothing
        -- iterate over all MIDI ports
        _, PortList = Session:engine():get_ports(ARDOUR.DataType.midi(), ARDOUR.PortList())
        for port in PortList[2]:iter () do
            -- skip output ports
            if not port:receives_input() then goto next end
            local midiport = port:to_midiport()
            -- and skip async event ports
            if midiport:isnil() then goto next end

            -- only use the port "MIDI control in"
            if port:name() ~= "MIDI control in" then goto next end
            -- can i rely on "port:name() === "MIDI control in" to watch only the configured Midi Control?
            -- Is there a better way to directly get the configured Control MIDI Device?

            local midiBuffer = midiport:get_midi_buffer(n_samples) -- get the midi-data buffers
            local events = midiBuffer:table() -- copy event list into lua table

            for k, event in pairs(events) do -- iterate over all events in the midi-buffer
                -- event is-a http://manual.ardour.org/lua-scripting/class_reference/#Evoral:Event

                ------------------------------------------------------------------------------------------------
                -- HERE I'm stuck. How to translate event into midi signal values Channel, Type, ProgramNumber
                ------------------------------------------------------------------------------------------------

                -- Goal:
                -- "if event is a ProgrammChange, jumpToMarker(ProgramNumber)"
            end
            ::next::
        end
        ::fine::
    end
end

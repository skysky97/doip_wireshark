-- @brief DoIP Protocol dissector plugin for wireshark
-- @author liyt
-- @date 2018.06.25

local NAME = "DoIP"
local TCP_DATA = 13400
local UDP_DISCOVERY = 13400
local UDP_TEST = 13401
local doip = Proto(NAME, "DoIP Protocol")

-- create fields of doip
local fields = doip.fields
fields.version = ProtoField.uint8(NAME .. ".version", "Protocol Version")
fields.version_r = ProtoField.uint8(NAME .. ".version_r", "Protocol Version Reverse")
fields.type = ProtoField.uint8(NAME .. ".type", "Payload Type")

function str_payload_type(payload_type)
	if (payload_type == 0x0000)
	then
		return "Generic nack"
	elseif (payload_type == 0x0001)
	then
		return "Vehicle identification request"
	elseif (payload_type == 0x0002)
	then
		return "Vehicle identification request with EID"
	elseif (payload_type == 0x0003)
	then
		return "Vehicle identification request with VIN"
	elseif (payload_type == 0x0004)
	then
		return "Vehicle identification announcement/response"
	elseif (payload_type == 0x0005)
	then
		return "Routing activation request"
	elseif (payload_type == 0x0006)
	then
		return "Routing activation response"
	elseif (payload_type == 0x8001)
	then
		return "Diagnostic message"
	elseif (payload_type == 0x8002)
	then
		return "Diagnostic message positive ack"
	elseif (payload_type == 0x8003)
	then
		return "Diagnostic message negative ack"
	else
		return "Unknown"
	end
end

function doip.dissector(tvb, pinfo, tree)
	local subtree = tree:add(doip, tvb())
	local offset = 0
	
	-- show protocol name in protocol column
	pinfo.cols.protocol = doip.name
	
	-- dissect field one by one, and add to protocol tree
	local version = tvb(offset, 1)
	subtree:add(fields.version, version)
	subtree:append_text(" Version " .. version:uint())
	offset = offset + 1
	
	subtree:add(fields.version_r, tvb(offset, 1))
	offset = offset + 1
	
	local payload_type = tvb(offset, 2)
	subtree:add(fields.type, payload_type)
	subtree:append_text(", payload type: " .. str_payload_type(payload_type:uint()))
	pinfo.cols.info:set(str_payload_type(payload_type:uint()))
	offset = offset + 2
end

-- register this dissector
DissectorTable.get("udp.port"):add(UDP_DISCOVERY, doip)
DissectorTable.get("tcp.port"):add(TCP_DATA, doip)
DissectorTable.get("udp.port"):add(UDP_TEST, doip)


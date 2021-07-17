local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "vRP_Policeprops") 
vRP = Proxy.getInterface("vRP")
local version = module("version")

HT = nil
TriggerEvent('HT_base:getBaseObjects', function(obj)
    HT = obj
end)


HT.RegisterServerCallback("TjekPoliti", function(source, cb, id)
    local user_id = vRP.getUserId({source})
    if vRP.hasGroup({user_id,"Politi-Job"}) then
        perm = true
    else
        perm = false
    end
    cb(perm)
end)
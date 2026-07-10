--  Please change here  --

zone_guid='cb6011'

--------------------------

function onLoad()
    self.createButton({
        click_function = "none",
        function_owner = self,
        label          = "0",
        position       = {0.0, 0.1, -0.05},
        rotation       = {0, 0, 0},
        width          = 0,
        height         = 0,
        font_size      = 400,
        font_color     = {1, 1, 1},
    })
    count(getObjectFromGUID(zone_guid))
end

function onObjectEnterZone(zone, object)
    if zone.getGUID() == zone_guid then
        count(zone)
    end
end

function onObjectLeaveZone(zone, object)
    if zone.getGUID() == zone_guid then
        count(zone)
    end
end

function count(zone)
    local total = 0
    for _, obj in ipairs(zone.getObjects()) do
        if obj.type == "Deck" or obj.type == "Bag" then
            for _, card in ipairs(obj.getObjects()) do
                if card.gm_notes then
                    data = JSON.decode(card.gm_notes)
                    if type(tonumber(data.VPC)) == "number" then
                        total = total + data.VPC
                    end
                end
            end
        elseif obj.type == "Tile" then
            if obj.getGMNotes() ~= "" then
                data = JSON.decode(obj.getGMNotes())
                if type(tonumber(data.VPC)) == "number" then
                    total = total + (data.VPC * obj.getQuantity())
                end
            end
        else
            if obj.getGMNotes() ~= "" then
                data = JSON.decode(obj.getGMNotes())
                if type(tonumber(data.VPC)) == "number" then
                    total = total + data.VPC
                end
            end
        end
    end
    self.editButton({index=0,label=total})
end
DECK_GUID = Global.getVar('DECK_GUID')
CARD_ZONE_GUIDS = Global.getTable('CARD_ZONE_GUIDS') 

function onLoad()
    cardZones = {}
    for _, guid in ipairs(CARD_ZONE_GUIDS) do
        local zone = getObjectFromGUID(guid)
        table.insert(cardZones, zone)
    end

    deck = getObjectFromGUID(DECK_GUID)
end

function refillCards()
    for _, zone in ipairs(cardZones) do
        if #zone.getObjects() == 0 then
            deck.takeObject({flip=true, position=zone.getPosition()})
        else
            spawnObject({
                type = "Chip_10",
                position = zone.getPosition(),
                scale = {0.5, 0.5, 0.5}
            })
        end
    end
end

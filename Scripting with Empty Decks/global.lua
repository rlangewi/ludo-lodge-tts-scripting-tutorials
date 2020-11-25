DECK_ZONE_GUID = 'af84a4'

function onLoad()
    deckZone = getObjectFromGUID(DECK_ZONE_GUID)
end

function getDeck()
    local zoneObjects = deckZone.getObjects()
    for _, item in ipairs(zoneObjects) do
        if item.tag == 'Deck' then
            return item
        end
    end
    for _, item in ipairs(zoneObjects) do
        if item.tag == 'Card' then
            return item
        end
    end
    return nil
end

function deckExists()
    return getDeck() != nil
end

function onChat()
    if deckExists() then
        getDeck().deal(1, "White")
    end
end

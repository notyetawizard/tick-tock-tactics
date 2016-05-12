map = {
    objects = {}
}

function map.new()
    return map
end
    
function map:move(name, dir)
    if not map.objects[name] then return end
    
    local dx, dy = self.objects[name].x, self.objects[name].y
    if dir == "up" then dy = dy - 1
    elseif dir == "down" then dy = dy + 1
    elseif dir == "left" then dx = dx - 1
    elseif dir == "right" then dx = dx + 1
    end
    
    if not map[dy] then map[dy] = {} end
    if not map[dy][dx] then map[dy][dx] = {} end
    if not map[dy][dx].object then 
        map[dy][dx].object = name
        map[map.objects[name].y][map.objects[name].x].object = nil
        map.objects[name].x, map.objects[name].y = dx, dy
    end
end

function map:newObject(name, x, y)
    self.objects[name] = {
        x = x,
        y = y
    }
    if not self[y] then self[y] = {} end
    if not self[y][x] then self[y][x] = {} end
    self[y][x].object = name
end

return map

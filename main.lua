mapsizey = 40 -- how tall
mapsizex = 80 -- how wide

-- 40x80 works well on a 720p screen
-- 160x200 works well on a 4k screen
-- i did not test any othe resolutions

off = "." -- empty tiles
on = "M" -- filled tiles

-- setting those to emoji works and is easier on the eyes but is painfully slow

-- https://www.youtube.com/watch?v=Y7hm0Xeicus
-- contained a link to one you can play in your browser
-- that one is limited in size so i made my own

function clearscreen(dist) -- clear the screen
	for i = 1, dist do
		print()
	end
end

mapt = {}
temp1 = 1
for i = 1, mapsizey do -- y axis
    temp2 = 1
	mapt[temp1] = {}
    for h = 1, mapsizex do -- x axis
		if (temp1 >= 8) then
			mapt[temp1][temp2] = on
		end
		if (temp1 <= 7) then
			mapt[temp1][temp2] = off
		end
        temp2 = temp2 + 1
    end
    temp1 = temp1 + 1
end

y = 1
x = 1
response = ""

::loop::
if (response == "w") then -- commands
	y = y - 1
	if (y <= 0) then
		y = 1
	end
end
if (response == "s") then
	y = y + 1
	if (y >= mapsizey + 1) then
		y = mapsizey
	end
end
if (response == "a") then
	x = x - 1
	if (x <= 0) then
		x = 1
	end
end
if (response == "d") then
	x = x + 1
	if (x >= mapsizex + 1) then
		x = mapsizex
	end
end
if (response:match("e")) then
	if (response:match("w")) then
		if (mapt[y - 1][x] == off) or (mapt[y - 2][x] == on) then
			goto bad
		end
		mapt[y][x] = off
		mapt[y - 1][x] = off
		mapt[y - 2][x] = on
	end
	if (response:match("s")) then
		if (mapt[y + 1][x] == off) or (mapt[y + 2][x] == on) then
			goto bad
		end
		mapt[y][x] = off
		mapt[y + 1][x] = off
		mapt[y + 2][x] = on
	end
	if (response:match("a")) then
		if (mapt[y][x - 1] == off) or (mapt[y][x - 2] == on) then
			goto bad
		end
		mapt[y][x] = off
		mapt[y][x - 1] = off
		mapt[y][x - 2] = on
	end
	if (response:match("d")) then
		if (mapt[y][x + 1] == off) or (mapt[y][x + 2] == on) then
			goto bad
		end
		mapt[y][x] = off
		mapt[y][x + 1] = off
		mapt[y][x + 2] = on
	end
end
::bad::
sx = 1 -- set start positions for scanning
sy = 1
map = ""
::loop1:: -- loop1 generates the world
tile = mapt[sy][sx] -- get a value
if (sx == x) and (sy == y) then
	map = map .. ">" .. tile
else
	map = map .. " " .. tile
end
sx = sx + 1 -- scan
if (sx >= mapsizex + 1) then
    sx = 1
    sy = sy + 1
    map = map .. "\n"
end
if (sy >= mapsizey + 1) then
    goto loop2
end
goto loop1
::loop2:: -- loop2 displays the values for you
clearscreen(80)
print(map)
response = io.read()
if (response == "q") then
    goto eof
end
goto loop
::eof::

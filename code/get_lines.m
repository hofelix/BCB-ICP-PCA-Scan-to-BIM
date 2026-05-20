function lines = get_lines(fid)

lines = 0;
while ~feof(fid)
fgetl(fid);
lines = lines + 1;
end
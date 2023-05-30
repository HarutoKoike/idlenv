function path2icloud
;
user = getenv('USER')
path = '/Users/' + user + '/Library/Mobile Documents/com~apple~CloudDocs'
return, path
end

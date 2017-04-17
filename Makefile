
FLAGS=-full64 -Mupdate -debug_access+pp
#+memcbk +v2k

build:
	vcs $(FLAGS) -F filelist 

clean:
	rm -r simv* DVEfiles csrc ucli.key *vpd 

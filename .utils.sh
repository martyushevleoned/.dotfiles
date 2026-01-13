sync_dotfiles()
{
    local host=$1
    rsync -av --delete ~/.dotfiles/ $host:~/.dotfiles/ --exclude '.git'
    [ -f ~/.study.sh ] && rsync -av ~/.study.sh $host:~/.study.sh
    [ -f ~/.work.sh ] && rsync -av ~/.work.sh $host:~/.work.sh
}

checksum()
{
    local output=${2:-checksum.log}
    echo '' > $output
	for src in $(find ${1:-.} -type f | sort); do
		md5sum $src >> $output  
	done
}

extract()
{
	local archive=$1
	local dst
	case $archive in
		*\.tar\.gz)
			dst=${archive%.tar.gz}
			mkdir -p $dst
			tar -xz -f $archive -C $dst
			;;
		*\.tar) 
			dst=${archive%.tar}
			mkdir -p $dst
			tar -x -f $archive -C $dst
			;;
		*\.zip)
            dst=${archive%.zip}
			unzip -q $archive
			;;
	esac
	echo $dst
}

unwrap()
{
	for archive in $(find ${1:-.} -type f); do
		local dir=$(extract $archive)
		[ -z "$dir" ] || unwrap $dir 
	done
}

compare()
{
    local dump1=`mktemp` dump2=`mktemp`
    local variant=('cat' 'hexdump -C' 'strings' 'objdump -s' 'readelf -a') parser=${variant[0]}
    local variant=('diff' 'meld' 'nvim') comparator=${variant[0]}
    local sources=($([ -z "${2:-}" ] && $(ls $1) || echo "$1 $2"))
    $parser ${sources[0]} > $dump1
    $parser ${sources[1]} > $dump2
    $comparator $dump1 $dump2
}

build()
{
	local build_dir='build'
	local build_type='Debug'
    # [ -f conanfile.py ] && conan build . # TODO
    [ -f conanfile.txt ] && conan install . --build=missing --output-folder=$build_dir --settings=build_type=$build_type
	[ -f CMakeLists.txt ] && cmake -B $build_dir -DCMAKE_BUILD_TYPE=$build_type && cmake --build $build_dir --verbose
    [ -f Makefile ] && make -j$(nproc)
}

clean()
{
	git clean -ffdx
	git reset --hard --recurse-submodule
	git submodule sync --recursive
	git submodule update --init --force --recursive
	git submodule foreach --recursive git clean -ffdx
}

format()
{
    find . -type f -regex '.*\.\(c\|h\|cpp\|hpp\)$' -exec clang-format -i {} \;
}

$@

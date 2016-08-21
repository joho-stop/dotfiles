import os
from pathlib import Path
from pathlib import PosixPath
import ycm_core

flags = [
'-Wall',
'-Wextra',
'-Wpedantic',
'-Werror',
'-Wno-long-long',
'-Wno-padded',
'-Wno-variadic-macros',
'-fexceptions',
'-DNDEBUG',
'-std=c++1z',
'-x',
'c++', # For a C project, you would set this to 'c' instead of 'c++'.
]

# Find matching file/dir directly inside the given directory, or recursively in
# parent directories
def find_outer_dir_with_file(curdir, file_to_find):
  assert os.path.isdir(curdir), "curdir is not a dir"
  while curdir != None and curdir != '' and curdir != '/': # disallow root
    if os.path.exists(os.path.join(curdir, file_to_find)):
      return curdir
    curdir = os.path.dirname(curdir)
  return None

def get_basedir(filedir):
  cmldir = find_outer_dir_with_file(filedir, 'CMakeLists.txt')
  if cmldir != None:
    return cmldir
  gitdir = find_outer_dir_with_file(filedir, '.git')
  if gitdir != None:
    return gitdir
  return None

def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags

HEADER_EXTENSIONS = [ '.h', '.hxx', '.hpp', '.hh', '.ipp', '.ixx' ]
def is_header_file(filename):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in HEADER_EXTENSIONS

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c' ]
def is_source_file(filename):
  extension = os.path.splitext(filename)[1]
  return extension in SOURCE_EXTENSIONS

def get_compile_info_from_db(db, filename):
  if None == db:
    return None

  if is_header_file(filename):
    # First, try related source files
    basename = os.path.splitext(filename)[0]
    for extension in SOURCE_EXTENSIONS:
      source_file = basename + extension
      if os.path.exists(source_file):
        compilation_info = db.GetCompilationInfoForFile(source_file)
        if compilation_info.compiler_flags_:
          return compilation_info
    # Then try the first source file in the same folder... meh
    for sibling in Path(filename).parents[0].iterdir():
      if not sibling.is_dir():
        sibling_ext = sibling.suffix
        if sibling_ext in SOURCE_EXTENSIONS:
          raw = os.path.abspath(bytes(sibling))
          compilation_info = db.GetCompilationInfoForFile(raw)
          if compilation_info.compiler_flags_:
            return compilation_info
          else:
            # Don't keep trying others
            return None
    return None
  return db.GetCompilationInfoForFile(filename)

def flags_with_abs_paths(flags, relative_to):
  return {
    'flags': MakeRelativePathsInFlagsAbsolute(flags, relative_to),
    'do_cache': True
  }

def get_db_folder(filedir):
  if None == filedir:
    return None
  DB_RELPATHS = ['target', 'target/debug', 'target/release', 'build', 'build/debug', 'build/release']
  for dbrel in DB_RELPATHS:
    dbdir = os.path.join(filedir, dbrel)
    dbfile = os.path.join(dbdir, 'compile_commands.json')
    if os.path.exists(dbfile):
      return os.path.abspath(dbdir)
  return None

def FlagsForFile(filename, **kwargs):
  assert not os.path.isdir(filename)
  filedir = os.path.dirname(os.path.abspath(filename))
  assert os.path.exists(filedir)
  basedir = get_basedir(filedir)

  db_folder = get_db_folder(basedir)
  if None == db_folder:
    db_folder = get_db_folder(filedir)

  if None != db_folder and os.path.exists(db_folder):
    db = ycm_core.CompilationDatabase(db_folder)
    db_compile_info = get_compile_info_from_db(db, filename)
    if None != db_compile_info:
      return flags_with_abs_paths(db_compile_info.compiler_flags_, db_compile_info.compiler_working_dir_)

  more_flags = flags + ['-I' + filedir]
  if None != basedir:
    return flags_with_abs_paths(more_flags, basedir)

  return flags_with_abs_paths(more_flags, filedir)

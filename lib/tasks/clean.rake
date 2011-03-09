# Create a list of all of the files to clean (i.e. emacs backup files).
CLEAN_FILES = FileList['**/*~']
# We don't exclude files because we do want to clean them up.
CLEAN_FILES.clear_exclude
# Create a task called clean (no namespace defined).
task :clean do
     rm CLEAN_FILES
end  
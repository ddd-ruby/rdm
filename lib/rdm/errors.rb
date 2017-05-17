module Rdm
  module Errors
    class ProjectAlreadyInitialized < StandardError
    end
    class PackageExists < StandardError
    end

    class PackageDirExists < StandardError
    end

    class SourceFileDoesNotExist < StandardError
    end
    
    class GitRepositoryNotInitialized < StandardError
    end

    class PackageFileDoesNotFound < StandardError
    end
  end
end

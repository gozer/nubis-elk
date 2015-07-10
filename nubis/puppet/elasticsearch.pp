require java

class {
    'elasticsearch':
        manage_repo  => true,
        repo_version => '1.5';
}
elasticsearch::instance {
    'es-01':
}

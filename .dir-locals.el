((nil
  . ((compile-command
      . "spago bundle --outfile public/js/main.min.js")

     (eglot-workspace-configuration
      . (:purescript (:outputDirectory "./output" :formatter "purs-tidy")))
     ))

 (auto-mode-alist
  . (("\\.lock\\'"
      . yaml-ts-mode)))

 (purescript-mode
  . ((eval
      . (eglot-ensure))))

 (haskell-mode
  . ((eval
      . (eglot-ensure))))

 (nix-mode
  . ((eval
      . (eglot-ensure))))
 )

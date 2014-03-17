TPCompose
=========
Example :

    _tpComposeViewController = [[TPComposeViewController alloc] initWithNibName:@"TPComposeViewController" bundle:nil];
    _tpComposeViewController.delegate = self;
    [[_tpComposeViewController view] setFrame:CGRectMake(0,0,320,568)];
    [_tpComposeViewController setPlaceholder:@"TEST"];
    [_tpComposeViewController showComposeWithTitle:@"Add Description" WithDescription:@"" Image:_redCarImage];


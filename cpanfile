on test => sub {
    requires 'Test::More', 0.98;
    requires 'Test::Fatal', 0.010;
    requires 'Test::Mock::Guard', 0.09;
};

on configure => sub {
    requires 'Module::Load'; # 5.10+ standard, bundled module
};

on 'develop' => sub {
};


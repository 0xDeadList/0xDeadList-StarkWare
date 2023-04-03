%lang starknet
from src.main import publishPrivateKey, isPrivateKeyLeaked, transferFrom
from starkware.cairo.common.cairo_builtins import HashBuiltin, EcOpBuiltin
from starkware.cairo.common.uint256 import Uint256

@external
func test_repetition{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_revert("TRANSACTION_FAILED", "ERC721: token already minted") %}
    publishPrivateKey(1);
    publishPrivateKey(1);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_collision{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_revert("TRANSACTION_FAILED", "ERC721: token already minted") %}
    publishPrivateKey(2);
    publishPrivateKey(3618502788666131213697322783095070105526743751716087489154079457884512865581);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_event_emit{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_events({"name": "Transfer", "data": [0, 456, 6387972689534309687154833283135443772, 4785580741027936964496764433346626005]}) %} // data: [from , to, pk_low, pk_high]
    publishPrivateKey(12345);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0xb4c3576628d24c46ecd37db0bf121b50, 0x5bb285326afe55b97decc54c261357f0f6df5ec94e8d28bda9676d12ff588f5, 456]}) %}
    publishPrivateKey(0xb4c3576628d24c46ecd37db0bf121b50);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0xba7761cb54390c7bd57f6ba4fc14ddef, 0x71e64d5db0754b6250686792c4c65ce5b82cfded049d47e9eaadaf0e91c2a49, 456]}) %}
    publishPrivateKey(0xba7761cb54390c7bd57f6ba4fc14ddef);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0x1dd35a2b135c3b962c57f25bf8e6caee, 0x56e9d50ef62d06c7c54384def6ee82e1e54552e643638c6f4b9136df345b26e, 456]}) %}
    publishPrivateKey(0x1dd35a2b135c3b962c57f25bf8e6caee);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0x6bb62d0b3e367fa871550becf74a5a80, 0x565544031bbbb8d9d3bf180b0b7b924c529862a3538980bfe07ff845b786c45, 456]}) %}
    publishPrivateKey(0x6bb62d0b3e367fa871550becf74a5a80);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0x62415f9bd23a73977995a831be275903, 0x64e40c548a6f25c4e5ccdde413030d3653faad86dcfecfa3f9fae1cfc3ca9c4, 456]}) %}
    publishPrivateKey(0x62415f9bd23a73977995a831be275903);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0x27f671a92f7bb3c24840593dc384d3a5, 0x163ab5b10fbd71c0ea69792a88079f2ab434152f5a9456b25fbd88a3dd9f60a, 456]}) %}
    publishPrivateKey(0x27f671a92f7bb3c24840593dc384d3a5);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0xc20ca369e3fd7b0e5cdc86ac345a6b04, 0x584fdfc5ad6bff95ae54f9b815fdea3d483134f58c1cf7bb92c4300cb579a48, 456]}) %}
    publishPrivateKey(0xc20ca369e3fd7b0e5cdc86ac345a6b04);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0xe6463cf8beb8c4107efc896e524b4657, 0xe02ba0c499fc6b1b195a54cac75a0b6f363f722e0a4160b3d55b7c947facd9, 456]}) %}
    publishPrivateKey(0xe6463cf8beb8c4107efc896e524b4657);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0xcb82f070ffd83e316c1cefff3b6f3b6c, 0x2520b9a348fb72c32a35667e5acc77bc62a6cbec716f8b8d097fcf7c5528794, 456]}) %}
    publishPrivateKey(0xcb82f070ffd83e316c1cefff3b6f3b6c);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0x3c1e9550e66958296d11b60f8e8e7a7ad990d07fa65d5f7652c4a6c87d4e3cc, 0x77a3b314db07c45076d11f62b6f9e748a39790441823307743cf00d6597ea43, 456]}) %}
    publishPrivateKey(0x3c1e9550e66958296d11b60f8e8e7a7ad990d07fa65d5f7652c4a6c87d4e3cc);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0x4c1e9550e66958296d11b60f8e8e7a7ad990d07fa65d5f7652c4a6c87d4e3cc, 0x3d8a9687c613b2be32b55c5c0460e012b592e2fbbb4fc281fb87b0d8c441b3e, 456]}) %}
    publishPrivateKey(0x4c1e9550e66958296d11b60f8e8e7a7ad990d07fa65d5f7652c4a6c87d4e3cc);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [0x7cc2767a160d4ea112b436dc6f79024db70b26b11ed7aa2cb6d7eef19ace703, 0x59a543d42bcc9475917247fa7f136298bb385a6388c3df7309955fcb39b8dd4, 456]}) %}
    publishPrivateKey(0x7cc2767a160d4ea112b436dc6f79024db70b26b11ed7aa2cb6d7eef19ace703);
    %{ expect_events({"name": "PrivateKeyLeaked", "data": [3618502788666131213697322783095070105526743751716087489154079457884512865582, 874739451078007766457464989774322083649278607533249481151382481072868806602, 456]}) %}
    publishPrivateKey(3618502788666131213697322783095070105526743751716087489154079457884512865582);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_private_key_zero{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_revert("TRANSACTION_FAILED", "Private key range invalid. Key: 0.") %}
    publishPrivateKey(0);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_is_private_key_leaked{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    alloc_locals;
    %{ stop_prank_callable = start_prank(456) %}
    let (is_leaked) = isPrivateKeyLeaked(0x5bb285326afe55b97decc54c261357f0f6df5ec94e8d28bda9676d12ff588f5);
    assert is_leaked = 0;
    publishPrivateKey(0xb4c3576628d24c46ecd37db0bf121b50);
    let (is_leaked) = isPrivateKeyLeaked(0x5bb285326afe55b97decc54c261357f0f6df5ec94e8d28bda9676d12ff588f5);
    assert is_leaked = 1;
    let (is_leaked) = isPrivateKeyLeaked(0x5bb285326afe55b97decc54c261357f0f6df5ec94e8d28bda9676d12ff588f6);
    assert is_leaked = 0;
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_transfer_to_zero_address{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    alloc_locals;
    %{ stop_prank_callable = start_prank(456) %}
    publishPrivateKey(12345);
    %{ expect_revert("TRANSACTION_FAILED", "ERC721: cannot transfer to the zero address") %}
    transferFrom(456, 0, Uint256(6387972689534309687154833283135443772, 4785580741027936964496764433346626005));
    return ();
}

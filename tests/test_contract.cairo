%lang starknet
from src.contract import publish_private_key
from starkware.cairo.common.cairo_builtins import HashBuiltin, EcOpBuiltin
from starkware.starknet.common.syscalls import get_caller_address

@external
func test_publish_private_key{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_revert("TRANSACTION_FAILED", "Private key has been reported. Key: 12345.") %}
    publish_private_key(12345);
    publish_private_key(12345);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_publish_private_key_emit_event{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_events({"name": "private_key_leaked", "data": [12345, 1628448741648245036800002906075225705100596136133912895015035902954123957052, 456]}) %}
    publish_private_key(12345);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_private_key_range_check_zero{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_revert("TRANSACTION_FAILED", "Private key range invalid. Key: 0.") %}
    publish_private_key(0);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_private_key_range_check_negative{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_revert("TRANSACTION_FAILED", "Private key range invalid. Key: -1.") %}
    publish_private_key(-1);
    %{ stop_prank_callable() %}
    return ();
}

@external
func test_transfer_event_emit{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*, ec_op_ptr: EcOpBuiltin*}() {
    %{ stop_prank_callable = start_prank(456) %}
    %{ expect_events({"name": "Transfer", "data": [0, 456, 6387972689534309687154833283135443772, 4785580741027936964496764433346626005]}) %} // data: [from , to, pk_low, pk_high]
    publish_private_key(12345);
    %{ stop_prank_callable() %}
    return ();
}

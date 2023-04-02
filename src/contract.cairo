%lang starknet
from starkware.cairo.common.bool import FALSE, TRUE
from starkware.cairo.common.cairo_builtins import EcOpBuiltin, HashBuiltin
from starkware.cairo.common.ec import StarkCurve, ec_mul
from starkware.cairo.common.ec_point import EcPoint
from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func private_key2leaker(private_key: felt) -> (leaker: felt) {
}

@event
func private_key_leaked(private_key: felt, public_key: felt, leaker: felt) {
}

@external
func publish_private_key{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, ec_op_ptr: EcOpBuiltin*}(
    private_key: felt
) {
    alloc_locals;
    let (leaker) = private_key2leaker.read(private_key);
    with_attr error_message("Private key has been reported. Key: {private_key}.") {
        assert leaker = 0;
    }
    let (caller_address) = get_caller_address();
    private_key2leaker.write(private_key, caller_address);

    let (p: EcPoint) = ec_mul(m=private_key, p=EcPoint(x=StarkCurve.GEN_X, y=StarkCurve.GEN_Y));
    let stark_key = p.x;
    private_key_leaked.emit(private_key=private_key, public_key=stark_key, leaker=caller_address);
    return ();
}

// @constructor
// upgrader
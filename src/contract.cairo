%lang starknet
from starkware.cairo.common.cairo_builtins import EcOpBuiltin, HashBuiltin
from starkware.cairo.common.ec import StarkCurve, ec_mul
from starkware.cairo.common.ec_point import EcPoint
from starkware.starknet.common.syscalls import get_caller_address
from openzeppelin.token.erc721.library import ERC721
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math import split_felt, assert_lt

@storage_var
func private_key2leaker(private_key: felt) -> (leaker: felt) {
}

@storage_var
func public_key2leaker(public_key: felt) -> (leaker: felt) {
}

@event
func private_key_leaked(private_key: felt, public_key: felt, leaker: felt) {
}

func _felt_to_uint{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    num: felt
) -> (res: Uint256) {
    let (high, low) = split_felt(num);
    tempvar res: Uint256;
    res.high = high;
    res.low = low;
    return (res=res);
}

@external
func publish_private_key{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr, ec_op_ptr: EcOpBuiltin*}(
    private_key: felt
) {
    alloc_locals;
    with_attr error_message("Private key range invalid. Key: {private_key}.") {
        assert_lt(0, private_key);
    }

    with_attr error_message("Private key has been reported. Key: {private_key}.") {
        let (leaker) = private_key2leaker.read(private_key);
        assert leaker = 0;
    }

    let (p: EcPoint) = ec_mul(m=private_key, p=EcPoint(x=StarkCurve.GEN_X, y=StarkCurve.GEN_Y));
    let public_key = p.x;
    let (caller_address) = get_caller_address();
    private_key2leaker.write(private_key, caller_address);
    public_key2leaker.write(public_key, caller_address);

    private_key_leaked.emit(private_key=private_key, public_key=public_key, leaker=caller_address);
    let (token_id) = _felt_to_uint(caller_address);
    ERC721._mint(caller_address, token_id);
    return ();
}

//
// Constructor
//

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
) {
    let name = '0xDeadList Burier';
    let symbol = 'Burier';
    ERC721.initializer(name, symbol);
    return ();
}

//
// Getters
//

@view
func name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (name: felt) {
    let (name) = ERC721.name();
    return (name,);
}

@view
func symbol{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (symbol: felt) {
    let (symbol) = ERC721.symbol();
    return (symbol,);
}

@view
func balanceOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(owner: felt) -> (
    balance: Uint256
) {
    let (balance: Uint256) = ERC721.balance_of(owner);
    return (balance,);
}

@view
func ownerOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    token_id: Uint256
) -> (owner: felt) {
    let (owner: felt) = ERC721.owner_of(token_id);
    return (owner,);
}

@view
func getApproved{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    token_id: Uint256
) -> (approved: felt) {
    let (approved: felt) = ERC721.get_approved(token_id);
    return (approved,);
}

@view
func isApprovedForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    owner: felt, operator: felt
) -> (is_approved: felt) {
    let (is_approved: felt) = ERC721.is_approved_for_all(owner, operator);
    return (is_approved,);
}

//
// Externals
//

@external
func approve{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    to: felt, token_id: Uint256
) {
    ERC721.approve(to, token_id);
    return ();
}

@external
func setApprovalForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    operator: felt, approved: felt
) {
    ERC721.set_approval_for_all(operator, approved);
    return ();
}

@external
func transferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    _from: felt, to: felt, token_id: Uint256
) {
    ERC721.transfer_from(_from, to, token_id);
    return ();
}

@external
func safeTransferFrom{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(
    _from: felt, to: felt, token_id: Uint256, data_len: felt, data: felt*
) {
    ERC721.safe_transfer_from(_from, to, token_id, data_len, data);
    return ();
}

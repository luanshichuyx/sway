contract;

use std::{bytes::Bytes, constants::ZERO_B256, context::balance_of, message::send_message, token::*};

abi TestFuelCoin {
    fn mint_coins(mint_amount: u64, sub_id: b256);
    fn burn_coins(burn_amount: u64, sub_id: b256);
    fn force_transfer_coins(coins: u64, asset_id: b256, target: ContractId);
    fn transfer_coins_to_address(coins: u64, asset_id: b256, to: Address);
    fn get_balance(asset_id: b256, target: ContractId) -> u64;
    fn mint_and_send_to_contract(amount: u64, to: ContractId, sub_id: b256);
    fn mint_and_send_to_address(amount: u64, to: Address, sub_id: b256);
    fn generic_mint_to(amount: u64, to: Identity, sub_id: b256);
    fn generic_transfer(amount: u64, asset_id: b256, to: Identity);
    fn send_message(recipient: b256, msg_data: Vec<u64>, coins: u64);

    fn address_mint_to(recipient: Address, amount: u64, sub_id: b256);
    fn address_transfer(recipient: Address, asset_id: b256, amount: u64);
    fn contract_mint_to(recipient: ContractId, amount: u64, sub_id: b256);
    fn contract_transfer(recipient: ContractId, asset_id: b256, amount: u64);
    fn identity_mint_to(recipient: Identity, amount: u64, sub_id: b256);
    fn identity_transfer(recipient: Identity, asset_id: b256, amount: u64);
}

impl TestFuelCoin for Contract {
    fn mint_coins(mint_amount: u64, sub_id: b256) {
        mint(sub_id, mint_amount);
    }

    fn burn_coins(burn_amount: u64, sub_id: b256) {
        burn(sub_id, burn_amount);
    }

    fn force_transfer_coins(coins: u64, asset_id: b256, target: ContractId) {
        force_transfer_to_contract(target, asset_id, coins);
    }

    fn transfer_coins_to_address(coins: u64, asset_id: b256, to: Address) {
        transfer_to_address(to, asset_id, coins);
    }

    fn get_balance(asset_id: b256, target: ContractId) -> u64 {
        balance_of(target, asset_id)
    }

    fn mint_and_send_to_contract(amount: u64, to: ContractId, sub_id: b256) {
        mint_to_contract(to, sub_id, amount);
    }

    fn mint_and_send_to_address(amount: u64, to: Address, sub_id: b256) {
        mint_to_address(to, sub_id, amount);
    }

    fn generic_mint_to(amount: u64, to: Identity, sub_id: b256) {
        mint_to(to, sub_id, amount);
    }

    fn generic_transfer(amount: u64, asset_id: b256, to: Identity) {
        transfer(to, asset_id, amount)
    }

    fn send_message(recipient: b256, msg_data: Vec<u64>, coins: u64) {
        let mut data = Bytes::new();
        if msg_data.len() > 0 {
            data.push(msg_data.get(0).unwrap().try_as_u8().unwrap());
            data.push(msg_data.get(1).unwrap().try_as_u8().unwrap());
            data.push(msg_data.get(2).unwrap().try_as_u8().unwrap());
        }

        send_message(recipient, data, coins);
    }

    fn address_mint_to(recipient: Address, amount: u64, sub_id: b256) {
        recipient.mint_to(sub_id, amount);
    }

    fn address_transfer(recipient: Address, asset_id: b256, amount: u64) {
        recipient.transfer(asset_id, amount);
    }

    fn contract_mint_to(recipient: ContractId, amount: u64, sub_id: b256) {
        recipient.mint_to(sub_id, amount);
    }

    fn contract_transfer(recipient: ContractId, asset_id: b256, amount: u64) {
        recipient.transfer(asset_id, amount);
    }

    fn identity_mint_to(recipient: Identity, amount: u64, sub_id: b256) {
        recipient.mint_to(sub_id, amount);
    }

    fn identity_transfer(recipient: Identity, asset_id: b256, amount: u64) {
        recipient.transfer(asset_id, amount);
    }
}

# NFT Marketplace Architecture Overview

## The Big Picture: How Web3 Apps Work

A Web3 NFT marketplace consists of **three main layers** that work together:

### 1. **Smart Contracts (The Blockchain Layer)**
   - **What they are**: Code that lives on the blockchain (Polygon in our case)
   - **Why they matter**: They enforce rules permanently. Once deployed, they can't be changed (unless you build upgradeability, which we won't for now).
   - **Our contracts**:
     - **NFT Contract**: Creates and owns the NFTs (ERC-721 standard)
     - **Marketplace Contract**: Handles buying/selling logic and holds the money

### 2. **Frontend (The User Interface)**
   - **What it is**: A Next.js web app that users interact with
   - **Why it matters**: Users can't interact with smart contracts directly—they need a UI
   - **Key components**:
     - Wallet connection (MetaMask)
     - Display NFTs from the blockchain
     - Forms to mint, list, and buy NFTs
     - Transaction status feedback

### 3. **The Connection Layer (How Frontend Talks to Blockchain)**
   - **MetaMask**: Browser extension that holds the user's wallet and signs transactions
   - **Ethers.js**: JavaScript library that translates our frontend actions into blockchain calls
   - **RPC Node**: The actual connection to Polygon network (we'll use public RPC endpoints)

## Data Flow: What Happens When You Buy an NFT?

1. **User clicks "Buy"** in the frontend
2. **Frontend uses Ethers.js** to call the Marketplace contract's `buyNFT()` function
3. **MetaMask pops up** asking user to confirm and pay for the transaction
4. **User confirms** → Transaction is sent to Polygon network
5. **Miners/Validators process** the transaction on Polygon
6. **Contract executes**:
   - Transfers NFT ownership from seller to buyer
   - Transfers payment (MATIC) from buyer to seller
   - Deducts marketplace fee
   - Emits events
7. **Frontend polls/watches** for the transaction confirmation
8. **UI updates** to show the new owner

## Project Structure

```
cursor-nft/
├── contracts/           # Solidity smart contracts
│   ├── NFT.sol         # Our ERC-721 NFT contract
│   └── Marketplace.sol # Our marketplace logic
├── scripts/            # Hardhat deployment and utility scripts
│   ├── deploy.js       # Deploy contracts to Polygon
│   └── verify.js       # Verify contracts on PolygonScan
├── test/               # Contract unit tests
│   └── Marketplace.test.js
├── frontend/           # Next.js application
│   ├── app/            # Next.js app router (if using App Router)
│   ├── components/     # React components
│   ├── hooks/          # Custom React hooks (wallet, contract interactions)
│   └── utils/          # Utility functions (contract addresses, ABIs)
├── hardhat.config.js   # Hardhat configuration
└── package.json        # Dependencies

```

## Key Concepts You'll Learn

1. **Hardhat**: Development environment for Solidity. Compiles contracts, runs tests, deploys to networks.
2. **OpenZeppelin**: Battle-tested, secure contract libraries (we use their ERC-721 base).
3. **ABI (Application Binary Interface)**: A JSON description of a contract's functions. The frontend needs this to know how to call the contract.
4. **Events**: Contracts emit events when things happen. The frontend listens to these to update the UI.
5. **IPFS**: Decentralized file storage for NFT metadata (images, descriptions). We'll set up the structure even if we mock it initially.

## Security Considerations (We'll Implement These)

- **Reentrancy Protection**: Prevents attack where a contract calls back into itself mid-execution
- **Access Control**: Only authorized functions can be called by the right people
- **Safe Math**: Solidity 0.8+ has built-in overflow protection, but we'll be explicit
- **Events**: Important for transparency—every action should be logged

---

**Next Step**: Setting up Hardhat and the project structure.
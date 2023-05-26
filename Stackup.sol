// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract StackUp {
    enum playerQuestStatus {
        NOT_JOINED,
        JOINED,
        SUBMITTED
    }
    
    enum SubmissionStatus {
        PENDING,
        REJECTED,
        APPROVED,
        REWARDED
    }

    struct Quest {
        uint256 questId;
        uint256 numberOfPlayers;
        string title;
        uint8 reward;
        uint256 numberOfRewards;
        uint256 startTime; // New: Quest start time
        uint256 endTime; // New: Quest end time
    }

    address public admin;
    uint256 public nextQuestId;
    mapping(uint256 => Quest) public quests;
    mapping(address => mapping(uint256 => playerQuestStatus)) public playerQuestStatuses;
    mapping(address => mapping(uint256 => SubmissionStatus)) public playerSubmissionStatuses; // New: Submission status for each player's quest

    constructor() {
        admin = msg.sender;
    }

    function createQuest(
        string calldata title_,
        uint8 reward_,
        uint256 numberOfRewards_,
        uint256 startTime_, // New: Quest start time parameter
        uint256 endTime_ // New: Quest end time parameter
    ) external {
        require(msg.sender == admin, "Only the admin can create quests");
        quests[nextQuestId].questId = nextQuestId;
        quests[nextQuestId].title = title_;
        quests[nextQuestId].reward = reward_;
        quests[nextQuestId].numberOfRewards = numberOfRewards_;
        quests[nextQuestId].startTime = startTime_;
        quests[nextQuestId].endTime = endTime_;
        nextQuestId++;
    }

    function joinQuest(uint256 questId) external questExists(questId) withinQuestTime(questId) {
        require(
            playerQuestStatuses[msg.sender][questId] == playerQuestStatus.NOT_JOINED,
            "Player has already joined/submitted this quest"
        );
        playerQuestStatuses[msg.sender][questId] = playerQuestStatus.JOINED;

        Quest storage thisQuest = quests[questId];
        thisQuest.numberOfPlayers++;
    }

    function submitQuest(uint256 questId) external questExists(questId) withinQuestTime(questId) {
        require(
            playerQuestStatuses[msg.sender][questId] == playerQuestStatus.JOINED,
            "Player must first join the quest"
        );
        playerQuestStatuses[msg.sender][questId] = playerQuestStatus.SUBMITTED;
    }

    function reviewSubmission(uint256 questId, address player, SubmissionStatus status) external isAdmin {
        require(playerQuestStatuses[player][questId] == playerQuestStatus.SUBMITTED, "Player must have submitted the quest");
        playerSubmissionStatuses[player][questId] = status;
    }

    function updateQuestTimes(uint256 questId, uint256 startTime, uint256 endTime) external isAdmin {
        quests[questId].startTime = startTime;
        quests[questId].endTime = endTime;
    }

    modifier questExists(uint256 questId) {
        require(quests[questId].reward != 0, "Quest does not exist");
        _;
    }

    modifier withinQuestTime(uint256 questId) {
        require(
            block.timestamp >= quests[questId].startTime && block.timestamp <= quests[questId].endTime,
            "Quest is not currently active"
        );
        _;
    }

    modifier isAdmin() {
        require(msg.sender == admin, "Only the admin can perform this operation");
        _;
    }
}
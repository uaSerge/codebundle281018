public class NewCaseListController {

    public List<Case> getNewCases() {
    
    List<Case> results = Database.query(
        'SELECT Id, CaseNumber FROM Case WHERE status = \'NEW\' LIMIT 10'
    );
    return results;
}
}
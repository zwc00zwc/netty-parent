package chat.core.db.model.query;

/**
 * @auther a-de
 * @date 2018/11/6 21:37
 */
public class ReceiveRedBagQuery extends BaseQuery {
    private Long id;
    private String receiverName;
    private Long domainId;
    private Long redbagId;
    private Integer status;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public Long getDomainId() {
        return domainId;
    }

    public void setDomainId(Long domainId) {
        this.domainId = domainId;
    }

    public Long getRedbagId() {
        return redbagId;
    }

    public void setRedbagId(Long redbagId) {
        this.redbagId = redbagId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}

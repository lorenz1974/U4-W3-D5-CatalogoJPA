package u4w3.dao;

import u4w3.entities.Utente;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import u4w3.exception.ErroreGenericoException;
import u4w3.exception.ElementoNonTrovatoException;

import java.util.List;

public class UtenteDAO {

    private final EntityManager em;

    public UtenteDAO(EntityManager em) {
        this.em = em;
    }

    public void save(Utente utente) throws ErroreGenericoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(utente);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante il salvataggio dell'utente: " + e.getMessage());
        }
    }

    public Utente findById(Long id) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            Utente utente = em.find(Utente.class, id);
            if (utente == null) {
                throw new ElementoNonTrovatoException("Nessun utente trovato con ID: " + id);
            }
            return utente;
        } catch (Exception e) {
            throw new ErroreGenericoException("Errore durante la ricerca dell'utente per ID: " + e.getMessage());
        }
    }

    public boolean checkByTessera(String tessera) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            Utente utente = em
                    .createQuery("SELECT u FROM Utente u WHERE u.numeroTessera = :tessera", Utente.class)
                    .setParameter("tessera", tessera)
                    .getSingleResult();
            // Se trova qualcosa, ritorna true
            return true;
        } catch (NoResultException exception) {
            // Se non trova nulla, ritorna false
            return false;
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'utente per tessera: " + exception.getMessage());
        }
    }

    public void delete(Utente utente) throws ErroreGenericoException, ElementoNonTrovatoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            if (utente == null) {
                throw new ErroreGenericoException("Utente non passato alla funzione di eliminazione");
            }
            if (em.find(Utente.class, utente.getId()) == null) {
                throw new ElementoNonTrovatoException("Utente non trovato nel database");
            }
            em.remove(utente);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante l'eliminazione dell'utente: " + e.getMessage());
        }
    }

    public List<Utente> findAll() throws ErroreGenericoException {
        try {
            return em.createQuery("SELECT u FROM Utente u", Utente.class).getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException("Errore durante il recupero di tutti gli utenti: " + e.getMessage());
        }
    }
}